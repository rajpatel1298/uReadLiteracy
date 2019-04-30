//
//  TrigraphAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/12/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class TrigraphAnalyzer{
    private var wordDetails = [WordAnalysisDetail]()
    private var word = ""
    private let title:String
    
    init(title:String){
        self.title = title
    }
    
    static func getAll()->[URLRequest]{
        let urls = ["https://www.youtube.com/watch?v=SdKW5KuDy1c&list=PL39iO7KLUw2mDudL0VIf5yyZbBQJZ0rzA",
                    "https://www.youtube.com/watch?v=kibwDQpqtA4",
                    "https://www.youtube.com/watch?v=AqxALefV3DA"
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
        
        addTrigraph()
        return wordDetails
    }
    
    // MARK: New Detail
    
    private func addTrigraph(){
        var urlRequestList = [URLRequest]()
        
        if(isTrigraph()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=SdKW5KuDy1c&list=PL39iO7KLUw2mDudL0VIf5yyZbBQJZ0rzA"))
            if LetterAnalyzer.matchAnyPosition(word: word, targets: ["tch"]){
                urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=kibwDQpqtA4"))
                urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=AqxALefV3DA"))
            }
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "This word has a trigraph in it.  When three consonants or two consonants and a vowel are together in a word, they sometimes blend together to make a completely different sound where you don’t hear any letter separately on its own.  This is called a trigraph (tri means three).", urlRequests: urlRequestList))
        }
    }
    
    private func isTrigraph()->Bool{
        if(LetterAnalyzer.matchAnyPosition(word: word, targets: ["dge","tch","nch", "nce", "dge", "ght", "nch"])){
            return true
        }
        return false
    }
}
