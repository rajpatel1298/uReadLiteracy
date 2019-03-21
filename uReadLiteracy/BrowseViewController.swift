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

class ReadViewController: UIViewController, WKNavigationDelegate,UIScrollViewDelegate,AVAudioRecorderDelegate,AVAudioPlayerDelegate{
    
    @IBOutlet weak var webView: WKWebviewWithHelpMenu!
    
    @IBOutlet weak var commentSectionView: UIView!
    fileprivate var browserCommentSectionVC:BrowserCommentSectionViewController!
    
    @IBOutlet weak var actitvityIndicator: UIActivityIndicatorView!
    
    var urlSegue:URL!
    let mainUrl = "http://www.manythings.org/voa/stories/"
    
    var logicController:BrowserLogicController!
    
    
    var maxBrowserOffset:Int!
    
    var recorder:Recorder!
    
    var player:AVAudioPlayer!
    
    var previousBtn:UIButton!
    
    let questionManager = ComprehensionQuestionManager()
    
    fileprivate var popupManager:ComprehensionPopupManager!
    fileprivate var alerts:BrowserVCAlerts!
    
    var currentArticle:ArticleModel!
    
    var articleReadingStopwatch = ArticleReadingStopwatch()
    
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
    
    private var oldScrollX:CGFloat = 0
    private var oldScrollY:CGFloat = 0
    
    
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
                    popup.frame = strongself.view.frame
                    popup.alpha = 0
                    strongself.view.addSubview(popup)
                    strongself.view.layoutIfNeeded()
     
                    UIView.animate(withDuration: popup.animationDuration) {
                        popup.alpha = 1
                    }
                    
                    strongself.oldScrollX = strongself.webView.scrollView.contentOffset.x
                    strongself.oldScrollY = strongself.webView.scrollView.contentOffset.y
                    
                    strongself.webView.scrollView.setContentOffset(CGPoint(x: strongself.webView.scrollView.contentOffset.x, y: strongself.webView.scrollView.contentOffset.y), animated: true)
                }
                
            })
            
            if(popupManager.isPopupShowing()){
                webView.scrollView.setContentOffset(CGPoint(x: oldScrollX, y: oldScrollY), animated: true)
            }
            
            browserCommentSectionVC.updateScrollPosition(position: y, maxOffset: maxBrowserOffset, url: url, didShow: {
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
        
        actitvityIndicator.isHidden = false
        actitvityIndicator.startAnimating()
        webView.scrollView.isScrollEnabled = false
        
        let url = webView.url?.absoluteString
        if logicController.isCurrentURLAnArticle(url: url!){
            maxBrowserOffset = Int(webView.scrollView.contentSize.height - webView.scrollView.bounds.height + webView.scrollView.contentInset.bottom)
            
            TopToolBarViewController.shared.enablePreviousAndRecordBtn()
        
            popupManager.setMaxYOffset(newValue: CGFloat(maxBrowserOffset))
        }
            
        else{
            TopToolBarViewController.shared.disablePreviousAndRecordBtn()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        actitvityIndicator.stopAnimating()
        actitvityIndicator.isHidden = true
        webView.scrollView.isScrollEnabled = true
        
        let url = webView.url?.absoluteString
        if logicController.isCurrentURLAnArticle(url: url!){
            currentArticle = ArticleModel(name: webView.title!, url: url!)
            browserCommentSectionVC.currentArticle = currentArticle
            currentArticle.incrementReadCount()
            
            articleReadingStopwatch.start()
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
            if(currentArticle != nil){
                articleReadingStopwatch.stop(article: currentArticle)
                GoalManager.shared.updateGoals(article: currentArticle) { (goal) in
                    GoalCompletePresenter.shared.show(goal: goal)
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

// MARK: Setup
extension ReadViewController{
    fileprivate func setup(){
        logicController = BrowserLogicController(mainURL: mainUrl)
        
        setupWebview()
        setupSocialMedia()
        setupHelpFunctionInMenuBar()
        
        recorder = Recorder(delegate:self)
        setupComprehensionPopup()
        
        alerts = BrowserVCAlerts(viewcontroller: self)
    }
    
    fileprivate func setupComprehensionPopup(){
        questionManager.populateGeneralQuestions()
        questionManager.populateFictionBeginning()
        questionManager.populateFictionPeriodic()
        questionManager.populateFictionEnd()
        
        let position1 = ComprehensionPopupModel(popupLocation: .Top, question: questionManager.selectRandomFictionBeginningQuestion())
        let position2 = ComprehensionPopupModel(popupLocation: .MiddleTop, question: questionManager.selectRandomFictionPeriodicQuestion())
        let position3 = ComprehensionPopupModel(popupLocation: .Middle, question: questionManager.selectRandomFictionPeriodicQuestion())
        let position4 = ComprehensionPopupModel(popupLocation: .MiddleBottom, question: questionManager.selectRandomFictionPeriodicQuestion())
        let position5 = ComprehensionPopupModel(popupLocation: .Bottom, question: questionManager.selectRandomFictionEndQuestion())
        
        
        popupManager = ComprehensionPopupManager(popupModels: [position1, position2, position3, position4, position5])
    }
    
    fileprivate func setupSocialMedia(){
        browserCommentSectionVC = (childViewControllers.first as! BrowserCommentSectionViewController)
        add(browserCommentSectionVC)
        commentSectionView = browserCommentSectionVC.view
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
        TopToolBarViewController.shared.onRecordBtnPressed = {
            if self.recorder.isRecording() {
                self.recorder.stopRecording()
            }
            else {
                self.recorder.startRecording(filename: (self.currentArticle?.getTitle())!) { (errStr) in
                    DispatchQueue.main.async {
                        self.alerts.showRecordErrorAlert()
                        print(errStr)
                    }
                }
            }
        }
    }
}


