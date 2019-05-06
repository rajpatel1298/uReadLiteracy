//
//  ConsonantDigraphsAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/12/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class ConsonantDigraphsAnalyzer{
    private var wordDetails = [WordAnalysisDetail]()
    private var word = ""
    private let title:String
    
    init(title:String){
        self.title = title
    }
    
    static func getAll()->[String]{
        let urls = ["https://www.youtube.com/watch?v=XUoRQiZqI6E",
                    "https://www.youtube.com/watch?v=M7iSFjbAg8c"
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
        
        addConsonantDigraphs()
        return wordDetails
    }
    
    // MARK: New Detail
    
    private func addConsonantDigraphs(){
        var videoHtmlList = [String]()
        
        if(isConsonantDigraphs()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=XUoRQiZqI6E").getHtml())
            if(LetterAnalyzer.matchAnyPosition(word: word, targets: ["ph"])){
                videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=M7iSFjbAg8c").getHtml())
            }
        }
        
        if(videoHtmlList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "This word has a consonant digraph.  This means that when two consonants are together in a word, they sometimes blend together to make a completely different sound where you don’t hear either letter.  There are also some cases where two consonants are together, but only one is pronounced.", videoHtmlList: videoHtmlList))
        }
    }
    
    private func isConsonantDigraphs()->Bool{
        let accepted = ["th", "ch", "sh", "ph", "wh", "ng", "ck", "squ"]
        if(LetterAnalyzer.matchAnyPosition(word: word, targets: accepted)){
            return true
        }
        if(LetterAnalyzer.matchEndingLetters(word: word, targets: ["b"])){
            return true
        }
        if(LetterAnalyzer.matchBeginningLetters(word: word, targets: ["k","w","ph"])){
            return true
        }
        
        let words = ["knowledge", "know", "knight", "knew", "knee", "kneel", "knife", "knit", "knob", "knock", "knot", "knuckle","pneumonia", "psalm", "psychology", "psychic", "psycho", "psychotic", "psychedelic"]
        if(words.contains(word)){
            return true
        }
        
        return false
    }
}
