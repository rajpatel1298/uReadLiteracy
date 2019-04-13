//
//  YoutubeURLRequestManager.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/17/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class YoutubeURLRequestManager{
    static let shared = YoutubeURLRequestManager()
    private var youtubeUrlRequests = [URLRequest]()
    
    func get(helpWord:HelpWordModel)->[URLRequest]{
        youtubeUrlRequests.removeAll()
        
        let word = helpWord.word
        
        if(LongVowelSoundAnalyzer.IorOWithTwoConsonants(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=bmTgHABs-_c")
        }
        if LongVowelSoundAnalyzer.singleVowel1(word: word){
            addUrl(url: "https://www.youtube.com/watch?v=qRVUULcS_xU")
        }
        
        if LongVowelSoundAnalyzer.singleVowel2(word: word){
            addUrl(url: "https://www.youtube.com/watch?v=4QRop-G9hw8")
        }
        
        if LongVowelSoundAnalyzer.consonantVowelConsonantAndE(word: word){
            addUrl(url: "https://www.youtube.com/watch?v=c3oA4wfUBak")
            addUrl(url: "https://www.youtube.com/watch?v=wJ2KpholmtE")
            addUrl(url: "https://www.youtube.com/watch?v=aV0piUUlXec&index=2&list=PL2IkMHFHWdEoN1HYS3c8oKLmxlsrJxvHr")
            addUrl(url: "https://www.youtube.com/watch?v=aV0piUUlXec&index=2&list=PL2IkMHFHWdEoN1HYS3c8oKLmxlsrJxvHr")
        }
        
        if(LongVowelSoundAnalyzer.consonantAConsonantE(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=krad_5lR80M")
            addUrl(url: "https://www.youtube.com/watch?v=8P4RJ3CXJFI")
        }
        
        if(LongVowelSoundAnalyzer.longATwoVowels(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=iRuoRzU0MPE")
        }
        
        if(LongVowelSoundAnalyzer.longOWithConsonantOConsonantE(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=SUp-nnGusvk")
        }
        
        if(LongVowelSoundAnalyzer.longOWithOA(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=_xYKYTf0JS8")
        }
        
        if(LongVowelSoundAnalyzer.longETwoVowels(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=iRuoRzU0MPE")
            addUrl(url: "https://www.youtube.com/watch?v=AnmKkqRJ980")
        }
        
        if(LongVowelSoundAnalyzer.longITwoVowels(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=WBwwcBRM3Rc")
            addUrl(url: "https://www.youtube.com/watch?v=ObVaokd5vq4")
        }
        
        if(LongVowelSoundAnalyzer.longIWithConsonantAndIConsonantE(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=osbtOG5cz40")
        }
        
        if(LongVowelSoundAnalyzer.longOWithConsonantOConsonantE(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=SUp-nnGusvk")
        }
        
        if(LongVowelSoundAnalyzer.longOTwoVowels(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=l2nH1KfOVXA")
        }
        
        if(LongVowelSoundAnalyzer.longUTwoVowels(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=J_s1eBCtaiI")
            addUrl(url: "https://www.youtube.com/watch?v=acLppUOFs3w")
        }
        
        if(LongVowelSoundAnalyzer.twoVowelsNoRules1(word: word)){
            if(LetterAnalyzer.matchAnyPosition(word: word, targets: ["oi"])){
                addUrl(url: "https://www.youtube.com/watch?v=EMdtke9HZVE")
            }
            if(LetterAnalyzer.matchAnyPosition(word: word, targets: ["oi","oy"])){
                addUrl(url: "https://www.youtube.com/watch?v=EtPpSYDsVZs")
                addUrl(url: "https://www.youtube.com/watch?v=cdI7fycHg1k")
            }
        }
        
        if(LongVowelSoundAnalyzer.twoVowelsNoRules2(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=7fb3Pdt8kxg")
            addUrl(url: "https://www.youtube.com/watch?v=k-n_LHGseNk")
            addUrl(url: "https://www.youtube.com/watch?v=10m4ujzFVqc")
        }
        
        if(LongVowelSoundAnalyzer.twoVowelsNoRules3(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=_vME18_vURk&list=PL2IkMHFHWdEoN1HYS3c8oKLmxlsrJxvHr&index=9")
        }
        
        if(LongVowelSoundAnalyzer.twoVowelsNoRules4(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=hDJQM9XxsCc")
        }
        
        if(LongVowelSoundAnalyzer.OO(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=_vME18_vURk&list=PL2IkMHFHWdEoN1HYS3c8oKLmxlsrJxvHr&index=9")
            addUrl(url: "https://www.youtube.com/watch?v=hDJQM9XxsCc")
        }
        
        if(LongVowelSoundAnalyzer.twoVowelsNoRules5(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=m0tfFJm76hg")
        }
        
        
        
        /*if(helpWord.beginningDifficult){
            let url = URL(string: "https://www.youtube.com/watch?v=WGERKJYjkQI") //no beginning video yet
            let request = URLRequest(url: url!)
            youtubeUrlRequests.append(request)
        }
        if(helpWord.endingDifficult){
            let url = URL(string: "https://www.youtube.com/watch?v=WGERKJYjkQI")
            let request = URLRequest(url: url!)
            youtubeUrlRequests.append(request)
        }
        if(helpWord.blendDifficult){
            let url = URL(string: "https://www.youtube.com/watch?v=k-n_LHGseNk")
            let request = URLRequest(url: url!)
            youtubeUrlRequests.append(request)
        }
        if(helpWord.multisyllabicDifficult){
            let url = URL(string: "https://www.youtube.com/watch?v=vNR2xyrZVv0")
            let request = URLRequest(url: url!)
            youtubeUrlRequests.append(request)
        }*/
        
        return youtubeUrlRequests
    }
    
    private func addUrl(url:String){
        let url = URL(string: url)
        let request = URLRequest(url: url!)
        youtubeUrlRequests.append(request)
    }
}
