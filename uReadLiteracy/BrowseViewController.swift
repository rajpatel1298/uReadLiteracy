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
import FirebaseAuth

class BrowseViewController: UIViewController, WKNavigationDelegate,UIScrollViewDelegate{
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var previousPageBarBtn: UIBarButtonItem!
    @IBOutlet weak var socialMediaView: UIView!
    
    var urlSegue:URL!
    let mainUrl = "http://www.manythings.org/voa/stories/"
    
    var uiController:BrowserUIController!
    var controller:BrowserController!
    
    var currentArticle:ArticleModel?
    
    
    private var browserSocialMediaVC:BrowserSocialMediaViewController!
    
    var maxBrowserOffset:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiController = BrowserUIController(viewcontroller: self)
        controller = BrowserController(webView: webView, url: mainUrl)
        
        webView.navigationDelegate = self
        
        webView.scrollView.delegate = self
    
        browserSocialMediaVC = (childViewControllers.first as! BrowserSocialMediaViewController)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webView.frame = view.frame
        socialMediaView.frame = CGRect(x: view.frame.origin.x, y: view.frame.height/2, width: view.frame.width, height: view.frame.height/2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        previousPageBarBtn.isEnabled = false
        loadMainPage()
        socialMediaView.isHidden = true
        webView.frame = view.frame
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webView.frame = view.frame
        loadMainPage()
        socialMediaView.isHidden = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        uiController.readScrollViewPosition()
        updateGoalIfNeeded()
    }
    
    private func updateGoalIfNeeded(){
        let currentYOffset = webView.scrollView.contentOffset.y
        let url = webView.url?.absoluteString
        
        if maxBrowserOffset == nil{
            return
        }
        
        if Int(currentYOffset) >= maxBrowserOffset!*90/100 {
            if(controller.isCurrentURLAnArticle(url: url!)){
                if(currentArticle != nil){
                    currentArticle?.stopRecordingTime()
                    GoalManager.shared.updateGoals(article: currentArticle!)
                }
            }
        }
    }
    
    func loadMainPage(){
        let url = URL(string: mainUrl)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    @IBAction func previousBtnPressed(_ sender: Any) {
        webView.goBack()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if(webView.canGoBack){
            previousPageBarBtn.isEnabled = true
        }
        else{
            previousPageBarBtn.isEnabled = false
        }
        
        let url = webView.url?.absoluteString
        
        if isReading(){
            currentArticle = ArticleModel(name: webView.title!, url: url!)
            currentArticle?.incrementReadCount()
            currentArticle?.startRecordingTime()
            
            maxBrowserOffset = Int(webView.scrollView.contentSize.height - webView.scrollView.bounds.height + webView.scrollView.contentInset.bottom)
            
            updatePopupManager()
            
            browserSocialMediaVC.currentArticle = currentArticle
        }
        
        else{
            uiController.popupManager.reset()
        }
    }
    
    func isReading()->Bool{
        let url = webView.url?.absoluteString
        return controller.isCurrentURLAnArticle(url: url!)
    }
    
    private func updatePopupManager(){
        let maxOffset = webView.scrollView.contentSize.height - webView.scrollView.bounds.height + webView.scrollView.contentInset.bottom
        
        uiController.popupManager.setMaxYOffset(value: maxOffset)
        uiController.popupManager.setYOffsetsToShowPopup(showAtYOffsets: [ComprehensionPopupShowPoint(y: maxOffset/2)])
    }
    
    func helpFunction(){
        controller.helpFunction { [weak self] (state,word) in
            switch(state){
            case .Success(let url):
                HelpWordModel(word: word!).save()
                
                self!.urlSegue = url as! URL
                self!.performSegue(withIdentifier: "BrowserToDictionaryWebViewSegue", sender: self)
                break
            case .Failure(let helpFunctionError):
                let helpFunctionError = helpFunctionError as! HelpFunctionError
                
                switch(helpFunctionError){
                case .MoreThanOneWord:
                    self!.uiController.showOnlyOneWordAlert()
                    break
                case .UnknownError:
                    break
                }
                
                break
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DictionaryWebViewController{
            destination.url = urlSegue
        }
    }
}





