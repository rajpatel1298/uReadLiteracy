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

class BrowseViewController: UIViewController, WKNavigationDelegate,UIScrollViewDelegate{
    
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var previousPageBarBtn: UIBarButtonItem!
    
    var urlSegue:URL!
    let mainUrl = "http://www.manythings.org/voa/stories/"
    
    var uiController:BrowserUIController!
    var controller:BrowserController!
    
    var currentArticle:ArticleModel?
    
    private let popupManager = ComprehensionPopupManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiController = BrowserUIController(viewcontroller: self)
        controller = BrowserController(webView: webView, url: mainUrl)
        
        webView.navigationDelegate = self
        setupHelpFunctionInMenuBar()
        
        webView.scrollView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        previousPageBarBtn.isEnabled = false
        loadMainPage()
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /*print("max offset: \(scrollView.contentSize.height - scrollView.bounds.height)" )
        print("current offset: \(scrollView.contentOffset.y)")*/
        
        let maxOffset = scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInset.bottom
        let currentYOffset = scrollView.contentOffset.y
        let url = webView.url?.absoluteString
        
        if currentYOffset >= maxOffset*90/100 && maxOffset > 0{
            if(controller.isCurrentURLAnArticle(url: url!)){
                if(currentArticle != nil){
                    currentArticle?.stopRecordingTime()
                    GoalManager.shared.updateGoals(article: currentArticle!)
                }
            }
        }
        
        if popupManager.shouldShowPopup(currentYOffset: currentYOffset){
            scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: currentYOffset), animated: true)
            
            let popup = ComprehensionPopup(frame: view.frame)
            
            popup.setupClosure(onAccept: { (answer) in
                print("answer for now: \(answer)")
            }, onSkip: {
                DispatchQueue.main.async {
                    //self.popup.removeFromSuperview() does not work :(
                    for subview in self.view.subviews{
                        if subview is ComprehensionPopup{
                            subview.removeFromSuperview()
                        }
                    }
                }
            })
            
            view.addSubview(popup)
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
            //DailyGoalModel.updateGoals(articleUpdate: currentArticle!)
            
            updatePopupManager()
        }
        
        else{
            popupManager.reset()
        }
    }
    
    private func updatePopupManager(){
        let maxOffset = webView.scrollView.contentSize.height - webView.scrollView.bounds.height + webView.scrollView.contentInset.bottom
        
        popupManager.setMaxYOffset(value: maxOffset)
        popupManager.setYOffsetsToShowPopup(showAtYOffsets: [ComprehensionPopupShowPoint(y: maxOffset/2)])
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
