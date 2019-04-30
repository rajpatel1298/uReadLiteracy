//
//  OtherCasesWordAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/13/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
class OtherCasesWordAnalyzer{
    private var wordDetails = [WordAnalysisDetail]()
    private var word = ""
    private let title:String
    
    init(title:String){
        self.title = title
    }
    
    static func getAll()->[URLRequest]{
        let urls = ["https://www.youtube.com/watch?v=XmVqgrmfslg",
                    "https://www.youtube.com/watch?v=m0tfFJm76hg",
                    "https://www.youtube.com/watch?v=m0tfFJm76hg",
                    "https://www.youtube.com/watch?v=QAFWtKePJ80",
                    "https://www.youtube.com/watch?v=3Uz9U7YhmCw",
                    //
            "https://www.youtube.com/watch?v=xZApEBQOHSQ",
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
        
        addExceptionAnalyze()
        addUnusualConsonantPronunciation()

        return wordDetails
    }
    
    // MARK: New Detail
    
    private func addExceptionAnalyze(){
        var urlRequestList = [URLRequest]()
        
        if(exceptionAnalyze()){
            if(["through", "thought", "though"].contains(word)){
                urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=XmVqgrmfslg"))
            }
            if LetterAnalyzer.matchAnyPosition(word: word, targets: ["ough" ,"augh"]){
                urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=m0tfFJm76hg"))
                if LetterAnalyzer.matchAnyPosition(word: word, targets: ["augh"]){
                    urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=m0tfFJm76hg"))
                    
                }
                if LetterAnalyzer.matchAnyPosition(word: word, targets: ["ough"]){
                    urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=QAFWtKePJ80"))
                }
                
                if(LetterAnalyzer.matchAnyPosition(word: word, targets: ["ou","ow"])){
                    if(!LetterAnalyzer.matchAnyPosition(of: word, numberOfLetters: 4, in: ["ough"])){
                        urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=3Uz9U7YhmCw"))
                    }
                }
            }
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "This word doesn’t follow an easy rule for pronouncing it.  In English some words just don’t follow the rules.  These videos point some of these out.  The best way to learn them is to just get used to recognizing the patterns the describe", urlRequests: urlRequestList))
        }
    }
    
    private func exceptionAnalyze()->Bool{
        let allowed = ["through", "thought", "though"]
        if(allowed.contains(word)){
            return true
        }
        
        if(LetterAnalyzer.matchEndingLetters(word: word, targets: ["ough"]) || LetterAnalyzer.matchEndingLetters(word: word, targets: ["augh"])){
            return true
        }
        
        
        if(LetterAnalyzer.matchAnyPosition(word: word, targets: ["ou","ow"])){
            if(LetterAnalyzer.matchAnyPosition(of: word, numberOfLetters: 4, in: ["ough"])){
                return false
            }
            return true
        }
        
        return false
    }
    
    // MARK: New Detail
    
    private func addUnusualConsonantPronunciation(){
        var urlRequestList = [URLRequest]()
        
        if(unusualConsonantPronunciation()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=xZApEBQOHSQ"))
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "This word has an unusual consonant sound.  Sometimes the /sh/ sound as in shoe is made with unusual letter combinations like ch, s, cean, cial.  The only way to learn when this sh sound is made is to learn to recognize the words that have this.  Sometimes it can really help, when you can’t get the word using what you know about sounds, to think about what you know about what would make sense in the sentence along with the word sound information you do have.  So for example if you see the word sugar and you don’t recognize that the s makes a sh sound, say the s sound.  From the rest of the sentence plus the slightly weird pronounciation, you’ll probably get it", urlRequests: urlRequestList))
        }
    }
    
    private func unusualConsonantPronunciation()->Bool{
        let words = ["chef", "machine", "charlotte", "michelle", "sure", "sugar", "ocean", "official", "precious", "ancient", "passion", "tissue", "pressure", "mission", "station", "motion", "champagne"]
        if(words.contains(word)){
            return true
        }
        return false
    }
}
