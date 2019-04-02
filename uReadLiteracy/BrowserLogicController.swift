//
//  BrowserLogicController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/11/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class BrowserLogicController{
    
    private let currentArticle:ArticleModel
    
    init(currentArticle:ArticleModel){
        self.currentArticle = currentArticle
    }
    
    func helpFunction(webView: WKWebviewWithHelpMenu, completionHandler:@escaping (_ state:State,_ error:HelpFunctionError?, _ word:HelpWordModel?)->Void){
        
        webView.evaluateJavaScript("window.getSelection().toString()", completionHandler: {
            (selectedWord: Any?, error: Error?) in
            
            guard var word = selectedWord as? String else{
                return
            }
            word = word.lowercased().replacingOccurrences(of: " ", with: "")
            
            if(self.onlyOneWordIsSelected(word: word)){
                var helpWord:HelpWordModel!
                
                let list:[HelpWordModel] = CoreDataGetter.shared.getList()
                for model in list{
                    if model.word == word{
                        helpWord = model
                        break
                    }
                }
                
                if(helpWord == nil){
                    helpWord = HelpWordModel(word: word)
                }
                
                helpWord.timesAsked = helpWord.timesAsked + 1
                helpWord.askedLastArticle = true
                
                CoreDataSaver.shared.save(helpModel: helpWord)
                completionHandler(.Success, nil, helpWord)
            }
            else{
                completionHandler(.Failure(""),HelpFunctionError.MoreThanOneWord,nil)
            }
        })
    }
    private func onlyOneWordIsSelected(word:String)->Bool{
        if((word.split(separator: " ").count) > 1 || word.split(separator: " ").count == 0){
            return false
        }
        return true
    }
    
    func updateDataWhenFinishReadingArticle(articleReadingStopwatch:ArticleReadingStopwatch){
        articleReadingStopwatch.stop()
        GoalManager.shared.updateGoals(article: currentArticle) { (goal) in
            GoalCompletePresenter.shared.show(goal: goal)
        }
    }
    
    func setupHelpWords(){
        let list:[HelpWordModel] = CoreDataGetter.shared.getList()
        
        for model in list{
            model.askedLastArticle = false
            CoreDataSaver.shared.save(helpModel: model)
        }
    }
    
    private var checkedHelpWords = false
    
    func updateHelpWordsThatWereNotAsked(webManager:WebViewManager){
        if !checkedHelpWords{
            checkedHelpWords = true
        }
        else{
            return
        }
        
        let list:[HelpWordModel] = CoreDataGetter.shared.getList()
        webManager.doesWordsExistInText(words: list) { (result) in
            for model in list{
                if(result[model.word] != nil){
                    if result[model.word]! && !model.askedLastArticle {
                        if(model.timesAsked>0){
                            model.timesAsked = model.timesAsked - 1
                            CoreDataSaver.shared.save(helpModel: model)
                        }
                    }
                }
            }
        }
        
        
        
    }
}
