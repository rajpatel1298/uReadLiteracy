//
//  BrowserLogicController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/11/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class BrowserLogicController{
    
    private let mainURL:String
    
    init(mainURL:String){
        self.mainURL = mainURL
    }
    
    func isCurrentURLAnArticle(url:String)->Bool{
        if(url.contains(mainURL) && url.count > mainURL.count){
            return true
        }
        return false
    }
    
    func helpFunction(webView: WKWebviewWithHelpMenu, completionHandler:@escaping (_ state:State)->Void){
        webView.evaluateJavaScript("window.getSelection().toString()", completionHandler: {
            (selectedWord: Any?, error: Error?) in
            
            guard let word = selectedWord as? String else{
                return
            }
            
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
            
            
        })
    }
    private func onlyOneWordIsSelected(word:String)->Bool{
        if((word.split(separator: " ").count) > 1 || word.split(separator: " ").count == 0){
            return false
        }
        return true
    }
}