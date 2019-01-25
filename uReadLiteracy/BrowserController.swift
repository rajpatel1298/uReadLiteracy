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
    
    init(webView:WKWebView, url:String){
        self.webView = webView
        mainURL = url
    }
    
    func helpFunction(completionHandler:@escaping (_ state:State, _ word:String?)->Void){
        getSelectedWord { (word) in
            if(self.onlyOneWordIsSelected(word: word)){
                if let url = URL(string: "http://www.dictionary.com/browse/\(word)?s=t"){
                    
                    completionHandler(.Success(url), word)
                }
                else{
                    completionHandler(.Failure(HelpFunctionError.UnknownError), nil)
                }
            }
            else{
                completionHandler(.Failure(HelpFunctionError.MoreThanOneWord), nil)
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
}
