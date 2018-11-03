//
//  BrowserWithPlayerController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/2/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class BrowserWithPlayerController{
    private var textview:UITextView!
    
    init(viewcontroller:BrowserWithPlayerViewController){
        self.textview = viewcontroller.textview
    }
    
    func helpFunction(completionHandler:(_ state:State)->Void){
        let selectedWords = getSelectedWord()
        
        if(onlyOneWordIsSelected()){
            if let url = URL(string: "http://www.dictionary.com/browse/\(selectedWords!)?s=t"){
                
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
    
    private func onlyOneWordIsSelected()->Bool{
        if((getSelectedWord()?.split(separator: " ").count)! > 1 || getSelectedWord()?.split(separator: " ").count == 0){
            return false
        }
        return true
    }
    
    private func getSelectedWord() -> String?{
        let range = textview.selectedRange
        let str = textview.text as NSString?
        let selectedWords = str?.substring(with: range)
        
        return selectedWords
    }
}
