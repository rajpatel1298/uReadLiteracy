//
//  ReadViewController.swift
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

class ReadViewController: UIViewController{
    
    @IBOutlet weak var webView: WKWebviewWithHelpMenu!
    @IBOutlet weak var commentSectionView: UIView!
    fileprivate var commentSectionVC:CommentSectionViewController!
    @IBOutlet weak var actitvityIndicator: UIActivityIndicatorView!
    
    var helpWordSegue:HelpWordModel!
    let mainUrl = "http://www.manythings.org/voa/stories/"
    var currentArticle:ArticleModel!
    
    fileprivate var logicController:ReadLogicController!
    fileprivate var questionManager: ComprehensionQuestionManager!
    fileprivate var webviewManager:WebViewManager!
    fileprivate var popupManager:ComprehensionPopupManager!
    
    
    fileprivate var recorder:Recorder!
    fileprivate var player:AVAudioPlayer!
    fileprivate var alerts:BrowserVCAlerts!
    fileprivate var articleReadingStopwatch = ArticleReadingStopwatch()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.frame
        commentSectionView.frame = CGRect(x: view.frame.origin.x, y: view.frame.height/2, width: view.frame.width, height: view.frame.height/2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMainPage()
        commentSectionView.isHidden = true
        webView.frame = view.frame
        
        setupTopBar()
        TopToolBarViewController.shared.disablePreviousAndRecordBtn()

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webView.frame = view.frame
        
        loadMainPage()
        commentSectionView.isHidden = true
        TopToolBarViewController.shared.disablePreviousAndRecordBtn()
        
        popupManager.resetPopupShownStatus()
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    fileprivate func addPopup(popup:ComprehensionPopup){
        popup.frame = view.frame
        popup.alpha = 0
        view.addSubview(popup)
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: popup.animationDuration) {
            popup.alpha = 1
        }
        
        webviewManager.scrollToCurrentCoordinate()
    }
    
    func loadMainPage(){
        let url = URL(string: mainUrl)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    func updateGoalIfNeeded(){
        let currentYOffset = webView.scrollView.contentOffset.y

        if logicController.atTheEndOfArticle(position: currentYOffset, maxOffset: webviewManager.getMaxOffset()){
            if(currentArticle != nil){
                articleReadingStopwatch.stop(article: currentArticle)
                GoalManager.shared.updateGoals(article: currentArticle) { (goal) in
                    GoalCompletePresenter.shared.show(goal: goal)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LearnDetailViewController{
            destination.inject(helpWord: helpWordSegue)
        }
    }
}

//MARK: Help Function
extension ReadViewController{
    func helpFunction(){
        logicController.helpFunction(webView: webView) { [weak self] (state, error, helpWord) in
            guard let strongSelf = self else{
                return
            }
            
            switch(state){
            case .Success():
                strongSelf.helpWordSegue = helpWord
                strongSelf.performSegue(withIdentifier: "ReadToLearnMoreSegue", sender: self)
                break
            case .Failure( _):
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
}


//MARK: Audio Record
extension ReadViewController:AVAudioRecorderDelegate,AVAudioPlayerDelegate{
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if recorder.isRecording{
            self.recorder.stopRecording()
        }
    }
}

// MARK: WebView
extension ReadViewController:WKNavigationDelegate,UIScrollViewDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        actitvityIndicator.startAnimating()
        webView.scrollView.isScrollEnabled = false
        
        let url = webView.url?.absoluteString
        if logicController.isCurrentURLAnArticle(url: url!){
            webviewManager.setMaxOffset()
            TopToolBarViewController.shared.enablePreviousAndRecordBtn()
            popupManager.setMaxYOffset(newValue: CGFloat(webviewManager.getMaxOffset()))
        }
        else{
            TopToolBarViewController.shared.disablePreviousAndRecordBtn()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        actitvityIndicator.stopAnimating()
        webView.scrollView.isScrollEnabled = true
        
        let url = webView.url?.absoluteString
        if logicController.isCurrentURLAnArticle(url: url!){
            currentArticle = ArticleModel(name: webView.title!, url: url!)
            commentSectionVC.currentArticle = currentArticle
            currentArticle.incrementReadCount()
            
            articleReadingStopwatch.start()
        }
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
            popupManager.updateScrollPosition(position: y, popupToAddToView: { [weak self] (popup) in
                
                guard let strongself = self else{
                    return
                }
                
                DispatchQueue.main.async {
                    strongself.addPopup(popup: popup)
                }
            })
            
            if(popupManager.isPopupShowing()){
                webviewManager.scrollToOldCoordinate()
            }
            
            commentSectionVC.updateScrollPosition(position: y, maxOffset: webviewManager.getMaxOffset(), url: url)
            
            updateGoalIfNeeded()
        }
    }
}

// MARK: Setup
extension ReadViewController{
    fileprivate func setup(){
        logicController = ReadLogicController(mainURL: mainUrl)
        
        setupWebview()
        setupSocialMedia()
        setupHelpFunctionInMenuBar()
        
        recorder = Recorder(delegate:self)
        setupComprehensionPopup()
        
        alerts = BrowserVCAlerts(viewcontroller: self)
        webviewManager = WebViewManager(webview: webView)
        actitvityIndicator.hidesWhenStopped = true
    }
    
    private func setupHelpFunctionInMenuBar(){
        let helpItem = UIMenuItem.init(title: "Help", action: #selector(helpFunction))
        UIMenuController.shared.menuItems = [helpItem]
        UIMenuController.shared.update()
        UIMenuController.shared.setMenuVisible(true, animated: true)
    }
    
    fileprivate func setupComprehensionPopup(){
        let position1 = ComprehensionPopupModel(popupLocation: .Middle, question: "What is Love? Baby don't hurt me, no more!")
        let position2 = ComprehensionPopupModel(popupLocation: .Top, question: "Test Top")
        
        popupManager = ComprehensionPopupManager(popupModels: [position1,position2])
    }
    
    fileprivate func setupSocialMedia(){
        commentSectionVC = (childViewControllers.first as! CommentSectionViewController)
        add(commentSectionVC)
        commentSectionView = commentSectionVC.view
        commentSectionVC.inject(didShow: {
            DispatchQueue.main.async {
                self.webView.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height/2)
            }
            
        }, didHide: {
            DispatchQueue.main.async {
                self.webView.frame = self.view.frame
            }
        })
    }
    
    fileprivate func setupWebview(){
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
    }
    
    fileprivate func setupTopBar(){
        TopToolBarViewController.currentController = self
        TopToolBarViewController.shared.onPreviousBtnPressed = {
            self.webView.goBack()
            self.popupManager.resetPopupShownStatus()
        }
        TopToolBarViewController.shared.onRecordBtnPressed = { [weak self] in
            guard let strongself = self else{
                return
            }
            
            if strongself.recorder.isRecording() {
                strongself.recorder.stopRecording()
            }
            else {
                strongself.recorder.startRecording(filename: (strongself.currentArticle?.getTitle())!) { (errStr) in
                    DispatchQueue.main.async {
                        strongself.alerts.showRecordErrorAlert()
                        print(errStr)
                    }
                }
            }
        }
    }
}


