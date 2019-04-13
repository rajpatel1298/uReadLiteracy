//
//  HelpWordModel.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/22/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import CoreData

class HelpWordModel{

    let word:String
    var timesAsked = 0
    var askedLastArticle = false
    
    init(word:String){
        self.word = word.lowercased()
    }
    init(word:String, timesAsked:Int,askedLastArticle:Bool){
        
        self.word = word.lowercased()
        self.timesAsked = timesAsked
        self.askedLastArticle = askedLastArticle
    }
        
    private func beginningDifficult(word:String)->Bool{
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
    
    private func endingDifficult(word:String)->Bool{
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
    
    func getDescription()->String{
        return "Not Implemented"
    }
}
