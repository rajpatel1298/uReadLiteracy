//
//  PrefixSuffixAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/10/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class PrefixSuffixAnalyzer{
    
    private var wordDetails = [WordAnalysisDetail]()
    private var word = ""
    
    private let title:String
    
    init(title:String){
        self.title = title
    }
    
    static func getAll()->[String]{
        let urls = ["https://www.youtube.com/watch?v=N5Qu7Qlf_eI",
                    "https://www.youtube.com/watch?v=q1-h63fewUc",
                    "https://www.youtube.com/watch?v=uu7OYa-itDQ",
                    "https://www.youtube.com/watch?v=IK8m-5JQmso",
                    "https://www.youtube.com/watch?v=ZOJrjNR7ZZM&list=PLKWZExqfRWNr4BCEZ7q5okLfjJPOylFLN"
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
        if(prefixSuffix()){
            if(LetterAnalyzer.matchBeginningLetters(word: word, targets: ["re", "anti", "bio", "trans"]) || LetterAnalyzer.matchEndingLetters(word: word, targets: ["ly", "ed", "ing", "er", "ment", "cian", "sion"])){
                videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=N5Qu7Qlf_eI").getHtml())
            }
            if(LetterAnalyzer.matchEndingLetters(word: word, targets: ["tion", "cian", "sion"])){
                videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=q1-h63fewUc").getHtml())
            }
            if(LetterAnalyzer.matchEndingLetters(word: word, targets: ["tion"])){
                videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=uu7OYa-itDQ").getHtml())
            }
            if(LetterAnalyzer.matchEndingLetters(word: word, targets: ["ure"])){
                videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=IK8m-5JQmso").getHtml())
            }
            if(LetterAnalyzer.matchBeginningLetters(word: word, targets: ["aqua", "ami", "bio", "hemo", "geo", "vita", "pre", "anti", "poly", "homo"]) || LetterAnalyzer.matchEndingLetters(word: word, targets: ["ly", "ish", "ology", "ism", "cide", "or", "er", "phobia", "kenisis"])){
                videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=ZOJrjNR7ZZM&list=PLKWZExqfRWNr4BCEZ7q5okLfjJPOylFLN").getHtml())
            }
        }
        
        if(videoHtmlList.count > 0){
            let detail = WordAnalysisDetail(title: title, detail: "Sometimes word meanings are changed by special beginnings, called prefixes, and endings, called suffixes.  This word has a prefix or a suffix.  When you see  prefix or suffix, sometimes it helps to chop them off the word (in your mind), figure out the word without them and then pronounce it with the prefix or suffix.  Learning the rules for recognizing syllables in words with more than one syllable can help you do this because prefixes and suffixes add syllables to words.", videoHtmlList: videoHtmlList)
            
            
            wordDetails.append(detail)
        }
        
        
        return wordDetails
    }
    
    
    private func prefixSuffix()->Bool{
        return prefix() || suffix()
    }
    
    private func prefix()->Bool{
        let prefixes = ["re", "anti", "bio", "trans","aqua", "ami", "bio", "hemo", "geo", "vita", "pre", "anti", "poly", "homo"]
        
        for prefix in prefixes{
            if(word.hasPrefix(prefix)){
                return true
            }
        }

        return false
    }
    private func suffix()->Bool{
        let suffixes = ["ly", "ed", "ing", "er", "ment", "cian", "sion","tion","ure", "ish", "ology", "ism", "cide", "or", "er", "phobia", "kenisis"]
        
        for suffix in suffixes{
            if(word.hasSuffix(suffix)){
                return true
            }
        }
        return false
    }
}
