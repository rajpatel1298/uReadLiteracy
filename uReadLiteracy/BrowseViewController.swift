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
    
    var currentArticle:ArticleModel?
    
    
    fileprivate var browserSocialMediaVC:BrowserSocialMediaViewController!
    
    var maxBrowserOffset:Int!
    
    var recorder:Recorder!
    
    var player:AVAudioPlayer!
    
    var previousBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiController = BrowserUIController(viewcontroller: self)
        controller = BrowserController(webView: webView, url: mainUrl, vc: self)
        
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
    
        browserSocialMediaVC = (childViewControllers.first as! BrowserSocialMediaViewController)
        recorder = Recorder(delegate:self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webView.frame = view.frame
        socialMediaView.frame = CGRect(x: view.frame.origin.x, y: view.frame.height/2, width: view.frame.width, height: view.frame.height/2)
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
                self.recorder.startRecording(filename: (self.currentArticle?.getTitle())!) { (errStr) in
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
        uiController.readScrollViewPosition()
        controller.updateGoalIfNeeded()
    }
    
    func loadMainPage(){
        let url = URL(string: mainUrl)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    @IBAction func previousBtnPressed(_ sender: Any) {
        
    }
    
    // when go to new webpage
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        updateCurrentArticleIfNeeded()
        updatePopupManager()
 
        
        if isReadingAnArticle(){
            maxBrowserOffset = Int(webView.scrollView.contentSize.height - webView.scrollView.bounds.height + webView.scrollView.contentInset.bottom)
            TopToolBarViewController.shared.disablePreviousAndRecordBtn()
        }
        
        else{
            TopToolBarViewController.shared.disablePreviousAndRecordBtn()
        }
    }

    func helpFunction(){
        controller.helpFunction { [weak self] (state) in
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DictionaryWebViewController{
            destination.url = urlSegue
        }
    }
    
    
}

// MARK: Webview did finish navigation

extension BrowseViewController{
    fileprivate func updatePopupManager(){
        if isReadingAnArticle(){
            uiController.updatePopupManager()
        }
            
        else{
            uiController.popupManager.reset()
        }
    }
    
    fileprivate func updateCurrentArticleIfNeeded(){
        let url = webView.url?.absoluteString
        
        if isReadingAnArticle(){
            currentArticle = ArticleModel(name: webView.title!, url: url!)
            currentArticle?.incrementReadCount()
            currentArticle?.startRecordingTime()
            browserSocialMediaVC.currentArticle = currentArticle
        }
    }
    
    func isReadingAnArticle()->Bool{
        let url = webView.url?.absoluteString
        return controller.isCurrentURLAnArticle(url: url!)
    }
}




