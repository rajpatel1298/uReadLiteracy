//
//  LearnMoreFunctionHelper.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/13/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation

class HelpWordHelper{
    static var sharedInstance = HelpWordHelper()
    
    func beginningDifficult(word:String)->Bool{
        let beginnings = ["bl", "br", "ch", "ci", "cl", "cr", "dis", "dr", "dw", "ex", "fl", "fr", "gl", "gr", "in","kn", "ph", "pl", "pr", "psy", "re", "sc", "sh", "shr", "sk", "sl","sm", "sn", "sp", "spr", "st", "str", "sw", "th", "thr", "tr", "tw", "un", "wh", "wr","eigh"]
        
        //calculate number of difficult beginning words
        for beg in beginnings{
            let currBeg = beg
            if(word.hasPrefix(currBeg) == true){
                return true
            }
        }
        
        return false
    }
    
    func endingDifficult(word:String)->Bool{
        let endings = ["augh", "cial", "cian", "ck", "dge", "ed", "ful", "gh", "ght", "ing", "ious", "ld", "le", "lf", "lk", "lm", "lp", "lt", "ly", "ment", "mp", "nce", "nch", "nd", "nk", "nse", "nt","ough","over", "psy", "pt", "tien", "tion", "ture"]
        //calculate number of difficult ending words
        for end in endings {
            let currEnd = end;
            if(word.hasSuffix(currEnd) == true){
                return true
            }
        }
        return false
    }
    
    func blendDifficult(word:String)->Bool{
        //calculate word blends
        var counter = 0;
        //   string = string.lowercased()
        for char in word.enumerated() {
            if ((counter == 1) && (isVowel(letter: char.element) || (char.element == "y" || char.element == "w"))){
                return true
            } else if(isVowel(letter: char.element)){
                counter += 1
            } else {
                counter = 0
            }
        }
        return false
    }
    
    func multisyllabicDifficult(word:String)->Bool{
        //calculate multisyllabic words
        var counter = 0
        
        for char in word.enumerated() {
            if counter == 1 && isVowel(letter: char.element) {
                return true
            }
            else if (counter == 1 && !isVowel(letter: char.element)) {
                //continue
            }
            else if (counter == 0 && isVowel(letter: char.element)){
                counter = 1
            }
            else {
                //do nothing
            }
        }
        return false
    }
    
    func isVowel(letter: Character) -> Bool{
        if(letter == "a" || letter == "e" || letter == "i" || letter == "o" || letter == "u"){
            return true
        }
        return false
    }
}
