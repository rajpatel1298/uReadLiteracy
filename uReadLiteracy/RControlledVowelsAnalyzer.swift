//
//  RControlledVowelsAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/12/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class RControlledVowelsAnalyzer{
    static func isRControlledVowels(word:String)->Bool{
        if(LetterAnalyzer.matchAnyPosition(word: word, targets: ["ir", "er", "ur","or", "ar"])){
            return true
        }
        return false
    }
}
