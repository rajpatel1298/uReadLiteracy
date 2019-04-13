//
//  ShortVowelSoundAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/10/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class ShortVowelSoundAnalyzer{
    private static func consonantLetterConsonant(word:String, letter:Character)->Bool{
        if(word.count >= 3){
            if(LetterAnalyzer.isConsonant(letter: word[word.count-3])){
                if(word[word.count-2] == letter){
                    if(LetterAnalyzer.isConsonant(letter: word[word.count-1])){
                        return true
                    }
                }
            }
        }
        return false
    }
    
    // ----------------------------------------------------------------
    
    //Short e: c-e-c pattern
    static func longE(word:String)->Bool{
        return consonantLetterConsonant(word: word, letter: "e")
    }
    
    //Short u: c-u-c
    static func longU(word:String)->Bool{
        return consonantLetterConsonant(word: word, letter: "u")
    }
    
    //Short o: c-o-c
    static func longO(word:String)->Bool{
        return consonantLetterConsonant(word: word, letter: "o")
    }
    
    //Short i: c-i-c
    static func longI(word:String)->Bool{
        return consonantLetterConsonant(word: word, letter: "i")
    }
    
    //Short a: c-a-c
    static func longA(word:String)->Bool{
        return consonantLetterConsonant(word: word, letter: "a")
    }
}
