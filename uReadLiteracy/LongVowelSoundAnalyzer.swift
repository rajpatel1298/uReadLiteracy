//
//  LongVowelSoundAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/9/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class LongVowelSoundAnalyzer:LetterAnalyzer{
   
    //I or O +two consonants= long vowel (kind, find, pint, Christ, climb, most, post, gold, sold, comb
    func IorOWithTwoConsonants(word:String)->Bool{
        if(word.count >= 3){
            if(word[word.count-3] == "i" || word[word.count-3] == "o" ){
                if(isConsonant(letter: word[word.count-2]) && isConsonant(letter: word[word.count-1])){
                    return true
                }
            }
            
        }
        return false
    }
    
    private let longVowelSoundSingleVowel1 = ["child", "gold", "I", "he", "she", "we"]
    
    //Long vowel sound, single vowel
    func longVowerSingleVowel1(word:String)->Bool{
        if(longVowelSoundSingleVowel1.contains(word)){
            return true
        }
        
        if(word.last != nil){
            if(word.last == "y" || word.last == "i"){
                return true
            }
        }
        return false
    }
    
    private let longVowelSoundSingleVowel2 = ["alien", "acorn", "agent","apricot", "ice", "only", "open", "me", "equal", "she","human", "island", "tidy", "idea", "united", "uniform"]
    
    func longVowerSingleVowel2(word:String)->Bool{
        if(longVowelSoundSingleVowel2.contains(word)){
            return true
        }
        return false
    }
    
    
    
    
    
    
    // Long vowel sound made by consonant(s)-vowel-consonant+e
    func longVowelSoundbyMultipleConsonantVowelConsonantAndE(word:String)->Bool{
        let exception = ["glove", "love", "have", "live", "give","active", "inventive", "olive", "come", "one", "there", "eye", "are", "done"]
        if(exception.contains(word)){
            return false
        }
        if(word.count >= 4){
            if(isConsonant(letter: word[word.count-4])){
                if(isVowel(letter: word[word.count-3])){
                    if(isConsonant(letter: word[word.count-2])){
                        if(word[word.count-1] == "e"){
                            if(word[word.count-2] == "v"){
                                return false
                            }
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
    // ----------------------------------------------------------------
    
    //Long a:  consonant + a + consonant + e
    func consonantAConsonantE(word:String)->Bool{
        if(word.count >= 4){
            if(isConsonant(letter: word[word.count-4])){
                if(word[word.count-1] == "a"){
                    if(isConsonant(letter: word[word.count-2])){
                        if(word[word.count-1] == "e"){
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
    //Long a vowel sound made by two vowels together:  ai, ay, ea, eigh
    func longATwoVowels(word:String)->Bool{
        let vowels = ["ai", "ay", "ea"]
        return matchAnyPosition(word: word, targets: vowels) || matchLastLetters(word: word, targets: ["eigh"])
        
    }
    
    // ----------------------------------------------------------------
    
    //Long o:  consonant + o + consonant + e
    func longOWithConsonantOConsonantE(word:String)->Bool{
        return consonantLetterConsonantLetter(word: word, letter1: "o", letter2: "e")
    }
    
    //
    
    
    //Long o: -oa-
    func longOWithOA(word:String)->Bool{
        return matchAnyPosition(word: word, targets:["oi"])
    }
    
    // ----------------------------------------------------------------
    
    //Long e vowel sound made by two vowels together:  ea, ee, ey
    func longETwoVowels(word:String)->Bool{
        let vowels = ["ea", "ee", "ey"]
        return matchAnyPosition(word: word, targets: vowels)
    }
    
    //Long I vowel sound made by two vowels
    func longITwoVowels(word:String)->Bool{
        let exception = ["piece", "alien", "field", "chief", "thief", "ceiling", "receipt", "receive"]
        
        if(exception.contains(word)){
            return false
        }
        
        let vowels = ["ie", "ei"]
        return matchAnyPosition(word: word, targets: vowels) || matchAnyPosition(of: word, numberOfLetters: 3, in: ["igh"])
    }
    
    
    // Long I, consonant(s) + i + consontant(s) + e
    func longIWithConsonantAndIConsonantE(word:String)->Bool{
        return consonantLetterConsonantLetter(word: word, letter1: "i", letter2: "e")
    }

    // ----------------------------------------------------------------
    
    // Long o made with consonant - o - consonant + e
    func longOWithConsonantAndOConsonantE(word:String)->Bool{
        return consonantLetterConsonantLetter(word: word, letter1: "o", letter2: "e")
    }
    
    //Long O vowel sound made by two vowels
    func longOTwoVowels(word:String)->Bool{
        let exception = ["canoe", "shoe"]
        
        if(exception.contains(word)){
            return false
        }
        
        let vowels = ["oa", "oo", "oe", "ow"]
        return matchAnyPosition(word: word, targets: vowels)
    }
    
    // ----------------------------------------------------------------
    
    
    //Long u sound made by two vowels:  ew, ue, ui, oo or consonant + u+ consonant + e
    func longUTwoVowels(word:String)->Bool{
        let accepted = ["uniform", "unicorn", "unique", "unity", "unite", "ukele"]
        if(accepted.contains(word)){
            return true
        }
        
        let vowels = ["ew", "ue", "ui", "oo"]
        return consonantLetterConsonantLetter(word: word, letter1: "u", letter2: "e") || matchAnyPosition(word: word, targets: vowels)
    }
    
    // ----------------------------------------------------------------
    
    // au, aw, ou, ow, oi, oy, or bread, thread, book, look, hook, brook.
    func twoVowelsNoRules1(word:String)->Bool{
        let accepted = ["bread", "thread", "book", "look", "hook", "brook"]
        if(accepted.contains(word)){
            return true
        }
        
        let vowels = ["au", "aw", "ou", "ow", "oi", "oy"]
        return matchAnyPosition(word: word, targets: vowels)
    }
    
    // Long vowel sounds made with two vowels together:  oa, ea, ai, ay
    func twoVowelsNoRules2(word:String)->Bool{
        let vowels = ["oa", "ea", "ai", "ay"]
        return matchAnyPosition(word: word, targets: vowels)
    }
    
    // -oo-
    func twoVowelsNoRules3(word:String)->Bool{
        let accepted = ["room", "moon", "food", "book", "cook", "good", "poor", "door", "floor", "blood", "flood", "cooperate", "coordinate","boot", "moon", "spoon", "goose", "moose", "food", "book", "cook", "wood", "foot"]
        if(accepted.contains(word)){
            return true
        }
        return false
    }
}
