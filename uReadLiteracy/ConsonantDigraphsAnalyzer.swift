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
    
    func getDetails(word:String)->[WordAnalysisDetail]{
        wordDetails.removeAll()
        self.word = word
        
        addConsonantDigraphs()
        return wordDetails
    }
    
    // MARK: New Detail
    
    private func addConsonantDigraphs(){
        var urlRequestList = [URLRequest]()
        
        if(isConsonantDigraphs()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=XUoRQiZqI6E"))
            if(LetterAnalyzer.matchAnyPosition(word: word, targets: ["ph"])){
                urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=M7iSFjbAg8c"))
            }
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(detail: "This word has a consonant digraph.  This means that when two consonants are together in a word, they sometimes blend together to make a completely different sound where you don’t hear either letter.  There are also some cases where two consonants are together, but only one is pronounced.", urlRequests: urlRequestList))
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
