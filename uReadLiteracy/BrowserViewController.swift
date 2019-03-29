//
//  BrowserViewController.swift
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
import Lottie

class BrowserViewController: UIViewController{
    
    @IBOutlet weak var webView: WKWebviewWithHelpMenu!
    
    @IBOutlet weak var commentBtn: LOTAnimationView!
    
    @IBOutlet weak var actitvityIndicator: UIActivityIndicatorView!
    
    var helpWordSegue:HelpWordModel!
    var currentArticle:ArticleModel!
    
    fileprivate var logicController:BrowserLogicController!
    fileprivate var questionManager: ComprehensionQuestionManager!
    fileprivate var webviewManager:WebViewManager!
    fileprivate var popupManager:ComprehensionPopupManager!
    
    fileprivate var recorder:Recorder!
    fileprivate var player:AVAudioPlayer!
    fileprivate var alerts:BrowserAlerts!
    fileprivate var articleReadingStopwatch = ArticleReadingStopwatch()
    
    func inject(article:ArticleModel){
        currentArticle = article
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hideCommentBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadWebPage()
        hideCommentBtn()
        
        setupTopBar()
        TopToolBarViewController.shared.hidePreviousCommentRecordBtn()

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func loadWebPage(){
        let url = URL(string: currentArticle.url)
        if(url != nil){
            let blockRules = getBlockRule()
            
            WKContentRuleListStore.default().compileContentRuleList(
                forIdentifier: "ContentBlockingRules",
                encodedContentRuleList: blockRules) { [weak self] (contentRuleList, error) in
                    
                    guard let strongself = self else{
                        return
                    }
                    
                    if error != nil{
                        strongself.showCannotLoadWebsiteAlert()
                        return
                    }
                    
                    let configuration = strongself.webView.configuration
                    configuration.userContentController.add(contentRuleList!)
                    
                    let url = URL(string: strongself.currentArticle.url)
                    if(url != nil){
                        let request = URLRequest(url: url!)
                        strongself.webView.load(request)
                    }
            }
        }
        else{
            showCannotLoadWebsiteAlert()
        }
    }
    
    private func showCannotLoadWebsiteAlert(){
        let alert = UIAlertController(title: "Cannot Load This Website", message: "Sorry, Please Try Again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] (_) in
            DispatchQueue.main.async {
                guard let strongself = self else{
                    return
                }
                strongself.dismiss(animated: true, completion: nil)
            }
        }))
    }
    
    private func showCommentBtn(){
        webView.frame = CGRect(x: view.frame.origin.x, y: 0, width: view.frame.width, height: view.frame.height*85/100)
        
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? CGFloat(0)
        
        commentBtn.frame = CGRect(x: view.frame.origin.x, y: view.frame.height*80/100, width: view.frame.width, height: view.frame.height*20/100 - tabBarHeight)
    }
    private func hideCommentBtn(){
        webView.frame = view.frame
        commentBtn.frame = CGRect(x: view.frame.origin.x, y: view.frame.height*80/100, width: 0, height: 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideCommentBtn()
        TopToolBarViewController.shared.hidePreviousCommentRecordBtn()
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
    
    func updateGoalIfNeeded(){
        let currentYOffset = webView.scrollView.contentOffset.y

        if webviewManager.atTheEndOfArticle(position: currentYOffset){
            articleReadingStopwatch.stop(article: currentArticle)
            GoalManager.shared.updateGoals(article: currentArticle) { (goal) in
                GoalCompletePresenter.shared.show(goal: goal)
            }
        }
    }
    
    fileprivate func updateScrollPositionForCommentBtn(position:CGFloat){
        if webviewManager.atTheEndOfArticle(position: position) {
            showCommentBtn()
        }
        else{
            hideCommentBtn()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LearnDetailViewController{
            destination.inject(helpWord: helpWordSegue)
        }
        if let destination = segue.destination as? CommentSectionViewController{
            destination.inject(currentArticle: currentArticle)
        }
    }
}

//MARK: Help Function
extension BrowserViewController{
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
extension BrowserViewController:AVAudioRecorderDelegate,AVAudioPlayerDelegate{
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if recorder.isRecording{
            self.recorder.stopRecording()
        }
    }
}

// MARK: WebView
extension BrowserViewController:WKNavigationDelegate,UIScrollViewDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        actitvityIndicator.startAnimating()
        webView.scrollView.isScrollEnabled = false
        
        
        TopToolBarViewController.shared.showPreviousCommentRecordBtn()
        popupManager.setMaxYOffset(newValue: CGFloat(webviewManager.getMaxOffset()))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        actitvityIndicator.stopAnimating()
        webView.scrollView.isScrollEnabled = true
        webviewManager.setMaxOffset()
        
        articleReadingStopwatch.start()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
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
        updateScrollPositionForCommentBtn(position: y)
        updateGoalIfNeeded()
    }
}


// MARK: Setup
extension BrowserViewController{
    fileprivate func setup(){
        logicController = BrowserLogicController(mainURL: currentArticle.url)
        
        setupWebview()
        setupHelpFunctionInMenuBar()
        
        recorder = Recorder(delegate:self)
        setupComprehensionPopup()
        
        alerts = BrowserAlerts(viewcontroller: self)
        webviewManager = WebViewManager(webview: webView)
        actitvityIndicator.hidesWhenStopped = true
        
        addGestureRecognizerToCommentBtn()
        commentBtn.autoReverseAnimation = true
        commentBtn.loopAnimation = true
        commentBtn.play()
        commentBtn.contentMode = .scaleAspectFit
    }
    
    private func addGestureRecognizerToCommentBtn(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onCommentSectionBtnPressed))
        commentBtn.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func onCommentSectionBtnPressed(){
        performSegue(withIdentifier: "ReadToCommentSectionSegue", sender: self)
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
    
    fileprivate func setupWebview(){
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
    }
    
    fileprivate func setupTopBar(){
        TopToolBarViewController.currentController = self
        TopToolBarViewController.shared.onPreviousBtnPressed = { [weak self] in
            guard let strongself = self else{
                return
            }
            strongself.popupManager.resetPopupShownStatus()
            strongself.performSegue(withIdentifier: "unwindToArticleSelectVC", sender: self)
        }
        TopToolBarViewController.shared.onRecordBtnPressed = { [weak self] in
            guard let strongself = self else{
                return
            }
            
            if strongself.recorder.isRecording() {
                strongself.recorder.stopRecording()
            }
            else {
                strongself.recorder.startRecording(filename: strongself.currentArticle.name) { (errStr) in
                    DispatchQueue.main.async {
                        strongself.alerts.showRecordErrorAlert()
                        print(errStr)
                    }
                }
            }
        }
        TopToolBarViewController.shared.onCommentBtnPressed = {
            [weak self] in
            guard let strongself = self else{
                return
            }
            strongself.onCommentSectionBtnPressed()
        }
    }
}


