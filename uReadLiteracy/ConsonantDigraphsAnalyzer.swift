//
//  ConsonantDigraphsAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/12/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class ConsonantDigraphsAnalyzer:LetterAnalyzer{
    func isConsonantDigraphs(word:String)->Bool{
        let accepted = ["th", "ch", "sh", "ph", "wh", "ng", "ck", "squ"]
        if(matchAnyPosition(word: word, targets: accepted)){
            return true
        }
        if(matchLastLetters(word: word, targets: ["b"])){
            return true
        }
        if(beginningLettersMatch(word: word, targets: ["k","w","ph"])){
            return true
        }
        
        let words = ["knowledge", "know", "knight", "knew", "knee", "kneel", "knife", "knit", "knob", "knock", "knot", "knuckle","pneumonia", "psalm", "psychology", "psychic", "psycho", "psychotic", "psychedelic"]
        if(words.contains(word)){
            return true
        }
        
        return false
    }
}
