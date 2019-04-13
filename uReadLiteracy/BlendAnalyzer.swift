//
//  BlendAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/12/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class BlendAnalyzer{
    static func blend(word:String)->Bool{
        /*
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
        return false*/
        
        let beginnings = ["bl", "br", "cl", "cr", "dr", "fl", "fr", "gl", "dr", "pl", "sc", "sk", "sl", "sn", "sp", "st", "sw", "tr", "squ","scr", "thr", "shr", "spl","str"]
        if(LetterAnalyzer.matchBeginningLetters(word: word, targets: beginnings)){
            return true
        }
        
        let middleOrEnd = ["ng", "nk", "nt", "nd"]
        if(LetterAnalyzer.matchAnyPosition(word: word, targets: middleOrEnd)){
            return true
        }
        
        return false
    }
}
