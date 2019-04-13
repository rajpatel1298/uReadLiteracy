//
//  MultisyllabicAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/12/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class MultisyllabicAnalyzer:LetterAnalyzer{
    func multisyllabic(word:String)->Bool{
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
}
