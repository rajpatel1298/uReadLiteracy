//
//  WordAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/9/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class WordAnalyzer{
    static func exceptionAnalyze(word:String)->Bool{
        let allowed = ["through", "thought", "though"]
        if(allowed.contains(word)){
            return true
        }
        
        if(LetterAnalyzer.matchEndingLetters(word: word, targets: ["ough"]) || LetterAnalyzer.matchEndingLetters(word: word, targets: ["augh"])){
            return true
        }
        
        
        if(LetterAnalyzer.matchAnyPosition(word: word, targets: ["ou","ow"])){
            if(LetterAnalyzer.matchAnyPosition(of: word, numberOfLetters: 4, in: ["ough"])){
                return false
            }
            return true
        }
        
        return false
    }
    
    static func unusualConsonantPronunciation(word:String)->Bool{
        let words = ["chef", "machine", "charlotte", "michelle", "sure", "sugar", "ocean", "official", "precious", "ancient", "passion", "tissue", "pressure", "mission", "station", "motion", "champagne"]
        if(words.contains(word)){
            return true
        }
        return false
    }
    
}
