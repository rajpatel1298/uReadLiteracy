//
//  MultisyllabicAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/12/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class MultisyllabicAnalyzer{
    private var wordDetails = [WordAnalysisDetail]()
    private var word = ""
    
    private let title:String
    
    init(title:String){
        self.title = title
    }
    
    static func getAll()->[String]{
        let urls = ["https://www.youtube.com/watch?v=vNR2xyrZVv0",
                    "https://www.youtube.com/watch?v=GDW0fwQoacc"
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
        
        var videoHtmlList = [String]()
        
        if(multisyllabic()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=vNR2xyrZVv0").getHtml())
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=GDW0fwQoacc").getHtml())
        }
        
        if(videoHtmlList.count > 0){
            let detail = WordAnalysisDetail(title: title, detail: "This is a long word; this is called a multisyllabic word which means more than one syllable.  Long words, words with more than one syllable, can be hard to read, but if you learn the rules for breaking them up into parts, this will help.  Once you break a word into its parts (syllables), you should be able to use many other “learn more” videos to understand how to pronounce those parts.", videoHtmlList: videoHtmlList)
            
            
            wordDetails.append(detail)
        }
        
        return wordDetails
    }
    
    
    
    private func multisyllabic()->Bool{
        //The words ends in -tion or -ture
        if(LetterAnalyzer.matchEndingLetters(word: word, targets: ["tion","ture"])){
            return true
        }
        //The word ends in d or t + ed
        if(LetterAnalyzer.matchEndingLetters(word: word, targets: ["ded","ted"])){
            return true
        }
        //The word ends in consonant+le
        if(word.count > 2 && LetterAnalyzer.matchEndingLetters(word: word, targets: ["le"]) && LetterAnalyzer.isConsonant(letter: word[word.count-3])){
            return true
        }
        //The word begins with be, re, de, ex and is followed by a consonant
        if(word.count > 2 && LetterAnalyzer.matchBeginningLetters(word: word, targets: ["be", "re", "de", "ex"]) && LetterAnalyzer.isConsonant(letter: word[2])){
            return true
        }
        if(LetterAnalyzer.vowelConsonantVowel(word: word)){
            return true
        }
        
        
        let consonantsToAvoid = ["ck", "ss", "th", "ph", "sh", "wh", "wr", "ng", "ch"]
        var avoidedConsonant = true
        for consonant in consonantsToAvoid{
            if(LetterAnalyzer.multipleConsonantsVowel(word: word, consonant: consonant)){
                avoidedConsonant = false
            }
        }
        
        if(avoidedConsonant){
            if(LetterAnalyzer.multipleConsonantsVowel(word: word)){
                return true
            }
        }
        
        return false
    }
}
