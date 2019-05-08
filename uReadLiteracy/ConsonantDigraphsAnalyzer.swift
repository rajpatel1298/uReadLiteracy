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
                    "https://www.youtube.com/watch?v=M7iSFjbAg8c",
                    "https://www.youtube.com/watch?v=38-ioYjE1e0&list=PL2IkMHFHWdEoN1HYS3c8oKLmxlsrJxvHr&index=5"
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
        
        if(firstRule()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=XUoRQiZqI6E").getHtml())
        }
        if(secondRule()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=M7iSFjbAg8c").getHtml())
        }
        if(thirdRule()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=38-ioYjE1e0&list=PL2IkMHFHWdEoN1HYS3c8oKLmxlsrJxvHr&index=5").getHtml())
        }
        
        if(videoHtmlList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "This word has a consonant digraph.  This means that when two consonants are together in a word, they sometimes blend together to make a completely different sound where you don’t hear either letter.  There are also some cases where two consonants are together, but only one is pronounced.", videoHtmlList: videoHtmlList))
        }
    }
    
    
    
    /*
     th, ch, sh, ph, wh, ng, ck, squ
     also silent consonants
     -mb (as in comb, numb, thumb, dumb
     kn- as in knot, know, knowledge, knife, knight
     w-as in wrist, write, wrinkle

     */
    
    private func firstRule()->Bool{
        
        let list = ["comb", "numb", "thumb", "dumb","knot", "know", "knowledge", "knife", "knight","wrist", "write", "wrinkle","debt", "subtle"]
        if(list.contains(word)){
            return true
        }
        let accepted = ["th", "ch", "sh", "ph", "wh", "ng", "ck", "squ"]
        if(LetterAnalyzer.matchAnyPosition(word: word, targets: accepted)){
            return true
        }
        return false
    }
    
    // ph
    private func secondRule()->Bool{
        if(LetterAnalyzer.matchBeginningLetters(word: word, targets: ["ph"])){
            return true
        }
        return false
    }
    
    private func thirdRule()->Bool{
        
        if(LetterAnalyzer.matchBeginningLetters(word: word, targets: ["k","w",])){
            return true
        }
        
        let words = ["knowledge", "know", "knight", "knew", "knee", "kneel", "knife", "knit", "knob", "knock", "knot", "knuckle","pneumonia", "psalm", "psychology", "psychic", "psycho", "psychotic", "psychedelic"]
        if(words.contains(word)){
            return true
        }
        
        return false
    }
}
