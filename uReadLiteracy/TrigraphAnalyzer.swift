//
//  TrigraphAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/12/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class TrigraphAnalyzer:LetterAnalyzer{
    func isTrigraph(word:String)->Bool{
        if(matchAnyPosition(word: word, targets: ["dge","tch","nch", "nce", "dge", "ght", "nch"])){
            return true
        }
        return false
    }
}
