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
            
            guard let word = selectedWord as? String else{
                return
            }
            
            if(self.onlyOneWordIsSelected(word: word)){
                let list:[HelpWordModel] = CoreDataGetter.shared.getList()
                for model in list{
                    if model.word == word{
                        completionHandler(.Success, nil, model)
                        return
                    }
                }
                
                let helpWord = HelpWordModel(word: word)
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
    
    func updateGoalIfNeeded(endOfArticle:Bool,articleReadingStopwatch:ArticleReadingStopwatch){
        if endOfArticle{
            articleReadingStopwatch.stop(article: currentArticle)
            GoalManager.shared.updateGoals(article: currentArticle) { (goal) in
                GoalCompletePresenter.shared.show(goal: goal)
            }
        }
    }
}
