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
    
    var uiController:BrowserUIController!
    var controller:BrowserController!
    var logicController:BrowserLogicController!
    
    fileprivate var browserSocialMediaVC:BrowserSocialMediaViewController!
    
    var maxBrowserOffset:Int!
    
    var recorder:Recorder!
    
    var player:AVAudioPlayer!
    
    var previousBtn:UIButton!
    
    var popupManager:ComprehensionPopupManager!
    private var popup:ComprehensionPopup!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiController = BrowserUIController(viewcontroller: self)
        controller = BrowserController(webView: webView, url: mainUrl, vc: self)
        logicController = BrowserLogicController(mainURL: mainUrl)
        
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
        
        
    
        browserSocialMediaVC = (childViewControllers.first as! BrowserSocialMediaViewController)
        recorder = Recorder(delegate:self)
        
        popup = ComprehensionPopup(frame: view.frame)
        
        view.addSubview(popup)
        popup.isHidden = true
        view.sendSubview(toBack: popup)
        
        popupManager = ComprehensionPopupManager(popup: popup, showPopup: {
            DispatchQueue.main.async {
                self.webView.scrollView.setContentOffset(CGPoint(x: self.webView.scrollView.contentOffset.x, y: self.webView.scrollView.contentOffset.y), animated: true)
            }
        })
    
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
                        self.uiController.showRecordErrorAlert()
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
        //showSocialMediaViewIfNeeded()
        //updateCurrentArticleIfNeeded()
        //updateGoalIfNeeded()
        popupManager.updateScrollPosition(position: scrollView.contentOffset.y)
        
    }
    
    func loadMainPage(){
        let url = URL(string: mainUrl)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
        
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        updateCurrentArticleIfNeeded()
        
        let url = webView.url?.absoluteString
        if logicController.isCurrentURLAnArticle(url: url!){
            maxBrowserOffset = Int(webView.scrollView.contentSize.height - webView.scrollView.bounds.height + webView.scrollView.contentInset.bottom)
            TopToolBarViewController.shared.enablePreviousAndRecordBtn()
            updatePopupManager()
        }
            
        else{
            TopToolBarViewController.shared.disablePreviousAndRecordBtn()
        }
    }

    func helpFunction(){
        logicController.helpFunction(webView: webView) { [weak self] (state) in
            switch(state){
            case .Success(let url):
                self!.urlSegue = url as! URL
                self!.performSegue(withIdentifier: "BrowserToDictionaryWebViewSegue", sender: self)
                break
            case .Failure(let helpFunctionError):
                let helpFunctionError = helpFunctionError as! HelpFunctionError
                self!.uiController.handleHelpError(helpFunctionError: helpFunctionError)
            }
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if recorder.isRecording{
            self.recorder.stopRecording()
        }
    }
    
    func updateGoalIfNeeded(){
        let currentYOffset = webView.scrollView.contentOffset.y
        let url = webView.url?.absoluteString
   
        if maxBrowserOffset == nil{
            return
        }
        
        if Int(currentYOffset) >= maxBrowserOffset!*90/100 {
            if logicController.isCurrentURLAnArticle(url: url!) {
                if(controller.currentArticle != nil){
                    controller.articleReadingTimer.stopRecordingTime()
                    GoalManager.shared.updateGoals(article: controller.currentArticle)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DictionaryWebViewController{
            destination.url = urlSegue
        }
    }
}

// MARK: Webview did finish navigation

extension BrowseViewController{
    fileprivate func updateCurrentArticleIfNeeded(){
        let url = webView.url?.absoluteString
        
        if logicController.isCurrentURLAnArticle(url: url!){
            controller.currentArticle = ArticleModel(name: webView.title!, url: url!)
            browserSocialMediaVC.currentArticle = controller.currentArticle
        }
    }
}


// MARK: Social Media
extension BrowseViewController{
    fileprivate func showSocialMediaViewIfNeeded(){
        let currentYOffset = Int(webView.scrollView.contentOffset.y)
        let url = webView.url?.absoluteString
        
        if maxBrowserOffset == nil{
            return
        }
        
        if !logicController.isCurrentURLAnArticle(url: url!){
            return
        }
        
        if currentYOffset >= maxBrowserOffset!*90/100 && maxBrowserOffset! > 0{
            if socialMediaView.isHidden{
                socialMediaView.isHidden = false
                socialMediaView.alpha = 0
                
                UIView.animate(withDuration: 1) {
                    self.webView.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height/2)
                    self.socialMediaView.alpha = 1
                }
            }
        }
        else{
            if !socialMediaView.isHidden{
                socialMediaView.alpha = 1
                
                UIView.animate(withDuration: 1, animations: {
                    self.webView.frame = self.view.frame
                    self.socialMediaView.alpha = 0
                }) { (completed) in
                    if completed{
                        self.socialMediaView.isHidden = true
                    }
                }
            }
        }
    }
}

// MARK: Comprehension Popup
extension BrowseViewController{
    func updatePopupManager(){
        popupManager.setMaxYOffset(value: CGFloat(maxBrowserOffset))
        popupManager.setYOffsetsToShowPopup(showAtYOffsets: [ComprehensionPopupShowPoint(y: CGFloat(maxBrowserOffset)/2)])
    }
}


