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
    
    var urlSegue:URL!
    let mainUrl = "http://www.manythings.org/voa/stories/"
    
    var uiController:BrowserUIController!
    var controller:BrowserController!
    
    var currentArticle:ArticleModel?
    
    fileprivate let popupManager = ComprehensionPopupManager()
    fileprivate var maxBrowserOffset:Int!
    private var browserSocialMediaVC:BrowserSocialMediaViewController!
    
    @IBOutlet weak var socialMediaView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiController = BrowserUIController(viewcontroller: self)
        controller = BrowserController(webView: webView, url: mainUrl)
        
        webView.navigationDelegate = self
        setupHelpFunctionInMenuBar()
        
        webView.scrollView.delegate = self
        
        SocialMediaComment.get(articleName: "asd", uid: "asd") { (_) in
            print()
        }
        
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
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateGoalIfNeeded()
        showSocialMediaViewIfNeeded()
        showPopupIfNeeded()
    }
    
    private func updateGoalIfNeeded(){
        let currentYOffset = webView.scrollView.contentOffset.y
        
        if maxBrowserOffset == nil{
            return
        }
        
        if Int(currentYOffset) >= maxBrowserOffset*90/100 {
            let url = webView.url?.absoluteString
            
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
        
        if(controller.isCurrentURLAnArticle(url: url!)){
            currentArticle = ArticleModel(name: webView.title!, url: url!)
            currentArticle?.incrementReadCount()
            currentArticle?.startRecordingTime()
            
            maxBrowserOffset = Int(webView.scrollView.contentSize.height - webView.scrollView.bounds.height + webView.scrollView.contentInset.bottom)
            
            updatePopupManager()
            
            browserSocialMediaVC.currentArticle = currentArticle
        }
        
        else{
            popupManager.reset()
        }
    }
    
    private func setupHelpFunctionInMenuBar(){
        let helpItem = UIMenuItem.init(title: "Help", action: #selector(helpFunction))
        UIMenuController.shared.menuItems = [helpItem]
        UIMenuController.shared.update()
        UIMenuController.shared.setMenuVisible(true, animated: true)
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

// MARK: Comprehension Popup
extension BrowseViewController{
    fileprivate func updatePopupManager(){
        let maxOffset = webView.scrollView.contentSize.height - webView.scrollView.bounds.height + webView.scrollView.contentInset.bottom
        
        popupManager.setMaxYOffset(value: maxOffset)
        popupManager.setYOffsetsToShowPopup(showAtYOffsets: [ComprehensionPopupShowPoint(y: maxOffset/2)])
    }
    
    fileprivate func showPopupIfNeeded(){
        let currentYOffset = webView.scrollView.contentOffset.y
        
        if popupManager.shouldShowPopup(currentYOffset: currentYOffset){
            webView.scrollView.setContentOffset(CGPoint(x: webView.scrollView.contentOffset.x, y: currentYOffset), animated: true)
            
            let popup = ComprehensionPopup(frame: view.frame)
            
            popup.setupClosure(onAccept: { (answer) in
                print("answer for now: \(answer)")
            }, onSkip: {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: popup.animationDuration, animations: {
                        popup.alpha = 0
                    }, completion: { (_) in
                        //self.popup.removeFromSuperview() does not work :(
                        for subview in self.view.subviews{
                            if subview is ComprehensionPopup{
                                subview.removeFromSuperview()
                            }
                        }
                    })
                }
            })
            
            view.addSubview(popup)
            
            popup.alpha = 0
            UIView.animate(withDuration: popup.animationDuration) {
                popup.alpha = 1
            }
        }
    }
}


// MARK: Social Media
extension BrowseViewController{
    fileprivate func showSocialMediaViewIfNeeded(){
        let currentYOffset = Int(webView.scrollView.contentOffset.y)
        
        if maxBrowserOffset == nil{
            return
        }
        
        if currentYOffset >= maxBrowserOffset*90/100 && maxBrowserOffset > 0{
            if socialMediaView.isHidden{
                UIView.animate(withDuration: 1) {
                    self.webView.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height/2)
                    self.socialMediaView.isHidden = false
                }
            }
        }
        else{
            if !socialMediaView.isHidden{
                UIView.animate(withDuration: 1) {
                    self.webView.frame = self.view.frame
                    self.socialMediaView.isHidden = true
                }
            }
        }
    }
}
