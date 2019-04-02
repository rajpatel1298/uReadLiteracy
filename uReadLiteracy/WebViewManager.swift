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
    
    init(webview:WKWebviewWithHelpMenu){
        self.webView = webview
    }
    
    func scrollToCurrentCoordinate(){
        oldScrollX = webView.scrollView.contentOffset.x
        oldScrollY = webView.scrollView.contentOffset.y
        
        webView.scrollView.setContentOffset(CGPoint(x: webView.scrollView.contentOffset.x, y: webView.scrollView.contentOffset.y), animated: true)
    }
    
    private func updateOldScrollToCurrent(){
        oldScrollX = webView.scrollView.contentOffset.x
        oldScrollY = webView.scrollView.contentOffset.y
    }
    
    func scrollToOldCoordinate(){
        print(oldScrollY)
        
        webView.scrollView.setContentOffset(CGPoint(x: oldScrollX, y: oldScrollY), animated: true)
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
    
    func atTheEndOfArticle(position:CGFloat)->Bool{
        if(maxOffset <= 0){
            return false
        }
        
        if Int(position) >= maxOffset*80/100 {
            return true
        }
        return false
    }
    
    func highlightHelpWords(completion:@escaping (_ err:Error?)->Void){
        updateOldScrollToCurrent()
        
        let list:[HelpWordModel] = CoreDataGetter.shared.getList()
        
        var currentWordCount = 0
        
        for word in list{
            if(word.timesAsked <= 2){
                highlightWord(word: word.word, color: .Green) { (err) in
                    if(err != nil){
                        completion(err)
                    }
                    else{
                        currentWordCount += 1
                        self.didHighLightAllHelpWord(current: currentWordCount, all: list.count, completion: completion)
                    }
                }
            }
            else if(word.timesAsked <= 4){
                highlightWord(word: word.word, color: .Yellow) { (err) in
                    if(err != nil){
                        completion(err)
                    }
                    else{
                        currentWordCount += 1
                        self.didHighLightAllHelpWord(current: currentWordCount, all: list.count, completion: completion)
                    }
                }
            }
            else{
                highlightWord(word: word.word, color: .Orange) { (err) in
                    if(err != nil){
                        completion(err)
                    }
                    else{
                        currentWordCount += 1
                        self.didHighLightAllHelpWord(current: currentWordCount, all: list.count, completion: completion)
                    }
                }
            }
        }
    }
    
    private func didHighLightAllHelpWord(current:Int,all:Int,completion:@escaping (_ err:Error?)->Void){
        if(current == all){
            completion(nil)
        }
    }
    
    private func highlightWord(word:String,color:HelpColor, completion:@escaping (_ err:Error?)->Void){
        if let path = Bundle.main.path(forResource: "UIWebViewSearch", ofType: "js"),
            let jsString = try? String(contentsOfFile: path, encoding: .utf8) {
            
            webView.evaluateJavaScript(jsString) {[weak self] (result, err) in
                guard let strongself = self else{
                    return
                }
                
                if(err != nil){
                    completion(err)
                }
                
                let startSearch = "uiWebview_HighlightAllOccurencesOfString\(color)('\(word)')"
                
                strongself.webView.evaluateJavaScript(startSearch) { (result2, err2) in
                    if(err2 != nil){
                        completion(err2)
                    }
                    else{
                        completion(nil)
                    }
                }
            }
        }
    }
    
}
