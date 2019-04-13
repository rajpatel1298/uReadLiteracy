//
//  LetterAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/9/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class LetterAnalyzer{
    static func isVowel(letter: Character) -> Bool{
        if(letter == "a" || letter == "e" || letter == "i" || letter == "o" || letter == "u"){
            return true
        }
        return false
    }
    
    static func isConsonant(letter: Character)->Bool{
        return !isVowel(letter: letter)
    }
    
    
    static func matchAnyPosition(word:String, targets:[String])->Bool{
        for target in targets{
            if(word.count >= target.count){
                for i in 0...(target.count-1){
                    if(word[i...(i+target.count)] == target){
                        return true
                    }
                }
                
            }
        }
        return false
    }
    
    static func matchAnyPosition(of word:String,numberOfLetters:Int,in list:[String])->Bool{
        if(word.count<numberOfLetters){
            return false
        }
        for i in 0...(word.count-numberOfLetters){
            let letters = word[i...(i+numberOfLetters-1)]
            
            if( list.contains(String(letters))){
                return true
            }
        }
        return false
    }
    
    static func matchEndingLetters(word:String,targets:[String])->Bool{
        for target in targets{
            if word.hasSuffix(target){
                return true
            }
            /*if(word.count >= target.count){
                let last = target.count - 1
                if(word[(last - target.count)...last] == target){
                    return true
                }
            }*/
        }
        return false
    }
    
    
    
    static func matchBeginningLetters(word:String,targets:[String])->Bool{
        for target in targets{
            if word.hasPrefix(target){
                return true
            }
            /*if(word.count >= target.count){
                if(word[0...(target.count-1)] == target ){
                    return true
                }
            }*/
        }
        
        
        return false
    }
    
    static func consonantLetterConsonantLetter(word:String, letter1:Character,letter2:Character)->Bool{
        if(word.count >= 4){
            if(isConsonant(letter: word[word.count-4])){
                if(word[word.count-3] == letter1){
                    if(isConsonant(letter: word[word.count-2])){
                        if(word[word.count-1] == letter2){
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
}
