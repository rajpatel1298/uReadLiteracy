//
//  ReadLogicController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/11/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class ReadLogicController{
    
    private let mainURL:String
    
    init(mainURL:String){
        self.mainURL = mainURL
    }
    
    
    
    func helpFunction(webView: WKWebviewWithHelpMenu, completionHandler:@escaping (_ state:State,_ error:HelpFunctionError?, _ word:HelpWordModel?)->Void){
        
        
        
        webView.evaluateJavaScript("window.getSelection().toString()", completionHandler: {
            (selectedWord: Any?, error: Error?) in
            
            guard let word = selectedWord as? String else{
                return
            }
            
            if(self.onlyOneWordIsSelected(word: word)){
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
}
