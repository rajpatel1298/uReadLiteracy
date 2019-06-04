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
    @IBOutlet weak var commentBtn: AnimationView!
    @IBOutlet weak var actitvityIndicator: UIActivityIndicatorView!
    
    var helpWordSegue:HelpWordModel!
    var currentArticle:ArticleModel!
    
    var logicController:BrowserLogicController!
    var webviewManager:WebViewManager!
    var popupManager:ComprehensionPopupManager!
    var achievementManager = AchievementManager()
    fileprivate let textToVoice = TextToVoiceService()
    
    var recorder:Recorder!
    fileprivate var player:AVAudioPlayer!
    var alerts:BrowserAlerts!
    

    fileprivate var scrollSubject = ScrollSubject()
    
    var questionManager = ComprehensionQuestionManager()
    
    func inject(article:ArticleModel){
        currentArticle = article
        
        logicController = BrowserLogicController(currentArticle: currentArticle)
        logicController.setupHelpWords()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        scrollSubject.attach(observer: popupManager)
        scrollSubject.attach(observer: webviewManager)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hideCommentBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webviewManager.injectJS()
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
        if(currentArticle.url == webView.url?.absoluteString){
            popupManager.resetPopupShownStatus()
        }
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    fileprivate func updateScrollPositionForCommentBtn(){
        if webviewManager.atTheEndOfArticle() {
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
    @objc func helpFunction(){
        logicController.helpFunction(webView: webView) { [weak self] (state, error, helpWord) in
            guard let strongSelf = self else{
                return
            }
            
            switch(state){
            case .Success:
                guard let helpWord = helpWord else{
                    fatalError("When success, need to have help word return")
                }
                
                strongSelf.textToVoice.setText(text: helpWord.word)
                strongSelf.textToVoice.playFast()
                strongSelf.webviewManager.highlightHelpWords(completion: { (err) in
                    if(err != nil){
                        fatalError(err.debugDescription)
                    }
                })
                
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
    
    @objc func learnMoreFunction(){
        logicController.helpFunction(webView: webView) { [weak self] (state, error, helpWord) in
            guard let strongSelf = self else{
                return
            }
            
            switch(state){
            case .Success:
                guard let helpWord = helpWord else{
                    fatalError("When success, need to have help word return")
                }
                strongSelf.helpWordSegue = helpWord
                
                DispatchQueue.main.async {
                    strongSelf.performSegue(withIdentifier: "BrowserToLearnDetailSegue", sender: self)
                }
                
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
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        actitvityIndicator.stopAnimating()
        webView.scrollView.isScrollEnabled = true
        
        webviewManager.setMaxOffset {[weak self] (err) in
            if err == nil{
                guard let strongself = self else{
                    return
                }
                strongself.popupManager.setMaxYOffset(newValue: CGFloat(strongself.webviewManager.getMaxOffset()))
            }
        }
        
        currentArticle.startTimer()
        
        webviewManager.highlightHelpWords {[weak self] (err) in
            if(err != nil){
                guard let strongself = self else{
                    return
                }
                strongself.webviewManager.highlightHelpWords { (err2) in
                    if(err2 != nil){
                        //fatalError(err.debugDescription)
                    }
                }
                //fatalError(err.debugDescription)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        scrollSubject.notify(with: y, view: view)
        
        if(popupManager.isPopupShowing()){
            webviewManager.scrollToOldCoordinate()
        }
        updateScrollPositionForCommentBtn()
        
        if webviewManager.atTheEndOfArticle(){
            logicController.saveArticle()
            logicController.showAchievementIfPossible(viewcontroller: self, achievementManager: achievementManager)
            logicController.updateHelpWordsThatWereNotAsked(webManager: webviewManager)
        }
    }
}





