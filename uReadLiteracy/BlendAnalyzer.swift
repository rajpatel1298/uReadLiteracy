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
    
    static func getAll()->[String]{
        let urls = ["https://www.youtube.com/watch?v=sYmwStHMezc",
                    "https://www.youtube.com/watch?v=_YfuGb8f7Jo",
                    "https://www.youtube.com/watch?v=sB2-mFb_O0E"
        ]
        
        var videoHtmlList = [String]()
        for url in urls{
            videoHtmlList.append(YoutubeLink(url: url).getHtml())
        }
        return videoHtmlList
    }
    
    func getDetails(word:String)->[WordAnalysisDetail]{
        wordDetails.removeAll()
        self.word = word
        
        addBlend()
        return wordDetails
    }
    
    // MARK: New Detail
    
    private func addBlend(){
        var videoHtmlList = [String]()
        
        if blend(){
            if LetterAnalyzer.matchBeginningLetters(word: word, targets: ["bl", "br", "cl", "cr", "dr", "fl", "fr", "gl", "dr", "pl", "sc", "sk", "sl", "sn", "sp", "st", "sw", "tr", "squ"]) || LetterAnalyzer.matchAnyPosition(word: word, targets: ["ng", "nk", "nt", "nd"]){
                videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=sYmwStHMezc").getHtml())
            }
            if(LetterAnalyzer.matchBeginningLetters(word: word, targets: ["scr", "thr", "shr", "spl", "str"])){
                videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=_YfuGb8f7Jo").getHtml())
            }
            if LetterAnalyzer.matchBeginningLetters(word: word, targets: ["cr", "cl", "fr", "st", "fl", "sk", "sl", "sw", "str"]) || LetterAnalyzer.matchEndingLetters(word: word, targets: ["nk"]){
                videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=sB2-mFb_O0E").getHtml())
            }
        }
        
        if(videoHtmlList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "This word has a consonant blend.  This means that when two consonants are together in a word, they sometimes blend together to make a sound in which you can hear each letter but they are smoothed out together.  The are called consonant blends.", videoHtmlList: videoHtmlList))
        }

    }
    
    private func blend()->Bool{
        /*
        //calculate word blends
        var counter = 0;
        //   string = string.lowercased()
        for char in word.enumerated() {
            if ((counter == 1) && (isVowel(letter: char.element) || (char.element == "y" || char.element == "w").getHtml())){
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
