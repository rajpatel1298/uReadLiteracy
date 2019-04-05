//
//  WebViewManager.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/17/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class WebViewManager{
    private let webView:WKWebviewWithHelpMenu
    
    private var oldScrollX:CGFloat = 0
    private var oldScrollY:CGFloat = 0
    private var maxOffset:Int = 0
    
    private let javascriptFileName = "UIWebView"
    
    init(webview:WKWebviewWithHelpMenu){
        self.webView = webview
    }
    
    func scrollToCurrentCoordinate(){
        oldScrollX = webView.scrollView.contentOffset.x
        oldScrollY = webView.scrollView.contentOffset.y
        
        webView.scrollView.setContentOffset(CGPoint(x: webView.scrollView.contentOffset.x, y: webView.scrollView.contentOffset.y), animated: true)
    }
    
    
    func scrollToOldCoordinate(){
        webView.scrollView.setContentOffset(CGPoint(x: oldScrollX, y: oldScrollY), animated: false)
    }
    
    func setMaxOffset(){
        //maxOffset = Int(webView.scrollView.contentSize.height - webView.scrollView.bounds.height + webView.scrollView.contentInset.bottom)
        //maxOffset = Int(webView.scrollView.contentSize.height + webView.scrollView.contentInset.bottom)
        webView.evaluateJavaScript("document.body.scrollHeight") { [weak self] (result, error) in
            guard let strongself = self else{
                return
            }
            
            if error == nil {
                if let result = result as? Int{
                    strongself.maxOffset = result - Int(strongself.webView.scrollView.bounds.height)
                }
            }
        }
    }
    
    func getMaxOffset()->Int{
        return maxOffset
    }
    
    func atTheEndOfArticle()->Bool{
        if(maxOffset <= 0){
            return false
        }
        
        if Int(webView.scrollView.contentOffset.y) >= maxOffset*80/100 {
            return true
        }
        return false
    }

    
    func highlightHelpWords(completion:@escaping (_ err:Error?)->Void){
        var currentWordCount = 0
        
        let list:[HelpWordModel] = CoreDataGetter.shared.getList()
        
        removeHighlights { [weak self] (removeErr) in
            guard let strongself = self else{
                return
            }
            
            if(removeErr != nil){
                completion(removeErr)
            }
            else{
                for word in list{
                    var color:HelpColor = .Green
                    
                    if(word.timesAsked == 0){
                        continue
                    }
                    if(word.timesAsked <= 2){
                        color = .Green
                    }
                    else if(word.timesAsked <= 4){
                        color = .Yellow
                    }
                    else{
                        color = .Orange
                    }
                    
                    strongself.highlightWord(word: word.word, color: color) { (err) in
                        if(err != nil){
                            completion(err)
                        }
                        else{
                            currentWordCount += 1
                            
                            if(currentWordCount == list.count){
                                completion(nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    private func highlightWord(word:String,color:HelpColor, completion:@escaping (_ err:Error?)->Void){
        let startSearch = "uiWebview_HighlightAllOccurencesOfString('\(word)','\(color.rawValue)')"
        
        webView.evaluateJavaScript(startSearch) { (result2, err2) in
            if(err2 != nil){
                completion(err2)
            }
            else{
                completion(nil)
            }
        }
    }
    
    func injectJS(){
        if let path = Bundle.main.path(forResource: javascriptFileName, ofType: "js"),
            let jsString = try? String(contentsOfFile: path, encoding: .utf8) {
            
            webView.evaluateJavaScript(jsString) { (result, err) in
                if(err != nil){
                    fatalError()
                }
            }
        }
    }
    
    private func removeHighlights(completion:@escaping (_ err:Error?)->Void){
        let removeHighlights = "uiWebview_RemoveAllHighlights()"
        webView.evaluateJavaScript(removeHighlights) {  (_, removeErr) in
            
            if(removeErr != nil){
                completion(removeErr)
            }
            else{
                completion(nil)
            }
        }
    }
    
    func doesWordsExistInText(words:[HelpWordModel],completion:@escaping ([String:Bool])->Void){
        let getAllParagraphs = "uiWebview_getAllParagraphs();"
        webView.evaluateJavaScript(getAllParagraphs) {  (result, removeErr) in
            
            guard var sentences = result as? String else{return}
            sentences = sentences.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\t", with: "").replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: "").lowercased()
            var eachWordArr = sentences.components(separatedBy: " ")
            for x in 0...(eachWordArr.count-1){
                eachWordArr[x] = eachWordArr[x].trimmingCharacters(in: .whitespacesAndNewlines)
            }
            
            var wordExist = [String:Bool]()
            
            for word in words{
                let word = word.word.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                
                if eachWordArr.contains(word){
                    wordExist[word] = true
                }
                else{
                    wordExist[word] = false
                }
            }
            
            completion(wordExist)
        }
    }
    
    
}
