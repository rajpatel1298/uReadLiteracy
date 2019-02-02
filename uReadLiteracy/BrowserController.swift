//
//  BrowserController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/20/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import WebKit

class BrowserController{
    private var webView: WKWebView!
    private var mainURL:String!
    private let vc:BrowseViewController
    
    init(webView:WKWebView, url:String, vc:BrowseViewController){
        self.webView = webView
        mainURL = url
        self.vc = vc
    }
    
    func helpFunction(completionHandler:@escaping (_ state:State)->Void){
        getSelectedWord { (word) in
            if(self.onlyOneWordIsSelected(word: word)){
                if let url = URL(string: "http://www.dictionary.com/browse/\(word)?s=t"){
                    HelpWordModel(word: word).save()
                    completionHandler(.Success(url))
                }
                else{
                    completionHandler(.Failure(HelpFunctionError.UnknownError))
                }
            }
            else{
                completionHandler(.Failure(HelpFunctionError.MoreThanOneWord))
            }
        }
    }
    
    func isCurrentURLAnArticle(url:String)->Bool{
        if(url.contains(mainURL) && url.count > mainURL.count){
            return true
        }
        return false
    }
    
    private func onlyOneWordIsSelected(word:String)->Bool{
        if((word.split(separator: " ").count) > 1 || word.split(separator: " ").count == 0){
            return false
        }
        return true
    }
    
    private func getSelectedWord(completionHandler:@escaping (String)->()){
        webView.evaluateJavaScript("window.getSelection().toString()", completionHandler: {
            (selectedWord: Any?, error: Error?) in
            completionHandler(selectedWord as! String)
        })
    }
    
    func updateGoalIfNeeded(){
        
        let currentYOffset = webView.scrollView.contentOffset.y
        let url = webView.url?.absoluteString
        let maxBrowserOffset = vc.maxBrowserOffset
        
        if maxBrowserOffset == nil{
            return
        }

        if Int(currentYOffset) >= maxBrowserOffset!*90/100 {
            if(isCurrentURLAnArticle(url: url!)){
                if(vc.currentArticle != nil){
                    vc.currentArticle?.stopRecordingTime()
                    GoalManager.shared.updateGoals(article: vc.currentArticle!)
                }
            }
        }
    }
}
