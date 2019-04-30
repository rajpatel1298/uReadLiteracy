//
//  BlendAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/12/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class BlendAnalyzer{
    private var wordDetails = [WordAnalysisDetail]()
    private var word = ""
    private let title:String
    
    init(title:String){
        self.title = title
    }
    
    static func getAll()->[URLRequest]{
        let urls = ["https://www.youtube.com/watch?v=sYmwStHMezc",
                    "https://www.youtube.com/watch?v=_YfuGb8f7Jo",
                    "https://www.youtube.com/watch?v=sB2-mFb_O0E"
        ]
        
        var urlRequestList = [URLRequest]()
        for url in urls{
            urlRequestList.append(StringToUrlRequest.get(url: url))
        }
        return urlRequestList
    }
    
    func getDetails(word:String)->[WordAnalysisDetail]{
        wordDetails.removeAll()
        self.word = word
        
        addBlend()
        return wordDetails
    }
    
    // MARK: New Detail
    
    private func addBlend(){
        var urlRequestList = [URLRequest]()
        
        if blend(){
            if LetterAnalyzer.matchBeginningLetters(word: word, targets: ["bl", "br", "cl", "cr", "dr", "fl", "fr", "gl", "dr", "pl", "sc", "sk", "sl", "sn", "sp", "st", "sw", "tr", "squ"]) || LetterAnalyzer.matchAnyPosition(word: word, targets: ["ng", "nk", "nt", "nd"]){
                urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=sYmwStHMezc"))
            }
            if(LetterAnalyzer.matchBeginningLetters(word: word, targets: ["scr", "thr", "shr", "spl", "str"])){
                urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=_YfuGb8f7Jo"))
            }
            if LetterAnalyzer.matchBeginningLetters(word: word, targets: ["cr", "cl", "fr", "st", "fl", "sk", "sl", "sw", "str"]) || LetterAnalyzer.matchEndingLetters(word: word, targets: ["nk"]){
                urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=sB2-mFb_O0E"))
            }
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "This word has a consonant blend.  This means that when two consonants are together in a word, they sometimes blend together to make a sound in which you can hear each letter but they are smoothed out together.  The are called consonant blends.", urlRequests: urlRequestList))
        }

    }
    
    private func blend()->Bool{
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
