//
//  BrowseViewController.swift
//  uReadLiteracy
//
//  Created by Raj Patel on 1/25/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import SafariServices
import WebKit
import SwiftSoup
import AVFoundation
import FirebaseAuth

class BrowseViewController: UIViewController, WKNavigationDelegate,UIScrollViewDelegate,AVAudioRecorderDelegate,AVAudioPlayerDelegate{
    
    @IBOutlet weak var webView: WKWebviewWithHelpMenu!
    @IBOutlet weak var socialMediaView: UIView!
    
    var urlSegue:URL!
    let mainUrl = "http://www.manythings.org/voa/stories/"
    
    var controller:BrowserController!
    var logicController:BrowserLogicController!
    
    fileprivate var browserSocialMediaVC:BrowserSocialMediaViewController!
    
    var maxBrowserOffset:Int!
    
    var recorder:Recorder!
    
    var player:AVAudioPlayer!
    
    var previousBtn:UIButton!
    
    fileprivate var popupManager:ComprehensionPopupManager!
    fileprivate var popup:ComprehensionPopup!
    fileprivate var alerts:BrowserVCAlerts!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webView.frame = view.frame
        socialMediaView.frame = CGRect(x: view.frame.origin.x, y: view.frame.height/2, width: view.frame.width, height: view.frame.height/2)
        
        popup.frame = view.frame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMainPage()
        socialMediaView.isHidden = true
        webView.frame = view.frame
        
        TopToolBarViewController.currentController = self
        TopToolBarViewController.shared.onPreviousBtnPressed = {
            self.webView.goBack()
        }
        TopToolBarViewController.shared.onRecordBtnPressed = {
            if self.recorder.isRecording() {
                self.recorder.stopRecording()
            }
            else {
                self.recorder.startRecording(filename: (self.controller.currentArticle?.getTitle())!) { (errStr) in
                    DispatchQueue.main.async {
                        self.alerts.showRecordErrorAlert()
                        print(errStr)
                    }
                }
            }
        }
        
        
        TopToolBarViewController.shared.disablePreviousAndRecordBtn()

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webView.frame = view.frame
        loadMainPage()
        socialMediaView.isHidden = true
        TopToolBarViewController.shared.disablePreviousAndRecordBtn()
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let webview = webView else{
            return
        }
        guard let url = webview.url?.absoluteString else{
            return
        }
        
        let y = scrollView.contentOffset.y
        
        if logicController.isCurrentURLAnArticle(url: url){
            popupManager.updateScrollPosition(position: y)
            browserSocialMediaVC.updateScrollPosition(position: y, maxOffset: maxBrowserOffset, url: url, didShow: {
                DispatchQueue.main.async {
                    self.webView.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height/2)
                }
                
            }, didHide: {
                DispatchQueue.main.async {
                    self.webView.frame = self.view.frame
                }
                
            })
            
            updateGoalIfNeeded()
        }
    }
    
    func loadMainPage(){
        let url = URL(string: mainUrl)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
        
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        let url = webView.url?.absoluteString
        if logicController.isCurrentURLAnArticle(url: url!){
            controller.currentArticle = ArticleModel(name: webView.title!, url: url!)
            browserSocialMediaVC.currentArticle = controller.currentArticle
            
            maxBrowserOffset = Int(webView.scrollView.contentSize.height - webView.scrollView.bounds.height + webView.scrollView.contentInset.bottom)
            
            TopToolBarViewController.shared.enablePreviousAndRecordBtn()
            
            popupManager.setMaxYOffset(newValue: CGFloat(maxBrowserOffset))
        }
            
        else{
            TopToolBarViewController.shared.disablePreviousAndRecordBtn()
        }
    }

    func helpFunction(){
        logicController.helpFunction(webView: webView) { [weak self] (state, error, url) in
            guard let strongSelf = self else{
                return
            }
            
            switch(state){
            case .Success():
                guard let url = url else{
                    return
                }
                strongSelf.urlSegue = url
                strongSelf.performSegue(withIdentifier: "BrowserToDictionaryWebViewSegue", sender: self)
                break
            case .Failure(let _):
                guard let helpFunctionError = error else{
                    return
                }
                strongSelf.handleHelpError(helpFunctionError: helpFunctionError)
            default:
                break
            }
        }
    }
    
    func handleHelpError(helpFunctionError: HelpFunctionError){
        switch(helpFunctionError){
        case .MoreThanOneWord:
            alerts.showOnlyOneWordAlert()
            break
        case .UnknownError:
            break
        }
    }
    
    func setupHelpFunctionInMenuBar(){
        let helpItem = UIMenuItem.init(title: "Help", action: #selector(helpFunction))
        UIMenuController.shared.menuItems = [helpItem]
        UIMenuController.shared.update()
        UIMenuController.shared.setMenuVisible(true, animated: true)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if recorder.isRecording{
            self.recorder.stopRecording()
        }
    }
    
    func updateGoalIfNeeded(){
        let currentYOffset = webView.scrollView.contentOffset.y

        if logicController.atTheEndOfArticle(position: currentYOffset, maxOffset: maxBrowserOffset){
            if(controller.currentArticle != nil){
                controller.articleReadingTimer.stopRecordingTime()
                GoalManager.shared.updateGoals(article: controller.currentArticle)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DictionaryWebViewController{
            destination.url = urlSegue
        }
    }
}

// MARK: Setup
extension BrowseViewController{
    fileprivate func setup(){
        controller = BrowserController(webView: webView, url: mainUrl, vc: self)
        logicController = BrowserLogicController(mainURL: mainUrl)
        
        setupWebview()
        setupSocialMedia()
        
        recorder = Recorder(delegate:self)
        setupComprehensionPopup()
        
        alerts = BrowserVCAlerts(viewcontroller: self)
    }
    
    fileprivate func setupComprehensionPopup(){
        popup = ComprehensionPopup(frame: view.frame)
        
        view.addSubview(popup)
        popup.isHidden = true
        view.sendSubview(toBack: popup)
        
        popupManager = ComprehensionPopupManager(popup: popup, didShowPopup: {
            DispatchQueue.main.async {
                self.webView.scrollView.setContentOffset(CGPoint(x: self.webView.scrollView.contentOffset.x, y: self.webView.scrollView.contentOffset.y), animated: true)
            }
        })
    }
    
    fileprivate func setupSocialMedia(){
        browserSocialMediaVC = (childViewControllers.first as! BrowserSocialMediaViewController)
        add(browserSocialMediaVC)
        socialMediaView = browserSocialMediaVC.view
    }
    
    fileprivate func setupWebview(){
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
    }
}


