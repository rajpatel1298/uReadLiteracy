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
        
        else if(LongVowelSoundAnalyzer.twoVowelsNoRules4(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=hDJQM9XxsCc")
        }
        else{
            if(LongVowelSoundAnalyzer.OO(word: word)){
                addUrl(url: "https://www.youtube.com/watch?v=_vME18_vURk&list=PL2IkMHFHWdEoN1HYS3c8oKLmxlsrJxvHr&index=9")
                addUrl(url: "https://www.youtube.com/watch?v=hDJQM9XxsCc")
            }
        }
        
        if(LongVowelSoundAnalyzer.twoVowelsNoRules5(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=m0tfFJm76hg")
        }
        
        if(ShortVowelSoundAnalyzer.shortE(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=H2aqKNc00Vc")
            addUrl(url: "https://www.youtube.com/watch?v=UQkPO3qpUCg")
        }
        
        if(ShortVowelSoundAnalyzer.shortU(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=17lyXMgkk9E")
        }
        
        if(ShortVowelSoundAnalyzer.shortO(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=4QRop-G9hw8")
        }
        
        if(ShortVowelSoundAnalyzer.shortI(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=ZY1ZRuEcah4")
        }
        
        if(ShortVowelSoundAnalyzer.shortA(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=UQkPO3qpUCg")
        }
        
        if(PrefixSuffixAnalyzer.prefixSuffix(word: word)){
            if(LetterAnalyzer.matchBeginningLetters(word: word, targets: ["re", "anti", "bio", "trans"]) || LetterAnalyzer.matchEndingLetters(word: word, targets: ["ly", "ed", "ing", "er", "ment", "cian", "sion"])){
                addUrl(url: "https://www.youtube.com/watch?v=N5Qu7Qlf_eI")
            }
            if(LetterAnalyzer.matchEndingLetters(word: word, targets: ["tion", "cian", "sion"])){
                addUrl(url: "https://www.youtube.com/watch?v=q1-h63fewUc")
            }
            if(LetterAnalyzer.matchEndingLetters(word: word, targets: ["tion"])){
                addUrl(url: "https://www.youtube.com/watch?v=uu7OYa-itDQ")
            }
            if(LetterAnalyzer.matchEndingLetters(word: word, targets: ["ure"])){
                addUrl(url: "https://www.youtube.com/watch?v=IK8m-5JQmso")
            }
            if(LetterAnalyzer.matchBeginningLetters(word: word, targets: ["aqua", "ami", "bio", "hemo", "geo", "vita", "pre", "anti", "poly", "homo"]) || LetterAnalyzer.matchEndingLetters(word: word, targets: ["ly", "ish", "ology", "ism", "cide", "or", "er", "phobia", "kenisis"])){
                addUrl(url: "https://www.youtube.com/watch?v=ZOJrjNR7ZZM&list=PLKWZExqfRWNr4BCEZ7q5okLfjJPOylFLN")
            }
        }
        
        if(MultisyllabicAnalyzer.multisyllabic(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=vNR2xyrZVv0")
            addUrl(url: "https://www.youtube.com/watch?v=GDW0fwQoacc")
        }
        
        if(WordAnalyzer.exceptionAnalyze(word: word)){
            if(["through", "thought", "though"].contains(word)){
                addUrl(url: "https://www.youtube.com/watch?v=XmVqgrmfslg")
            }
            if LetterAnalyzer.matchAnyPosition(word: word, targets: ["ough" ,"augh"]){
                addUrl(url: "https://www.youtube.com/watch?v=m0tfFJm76hg")
                if LetterAnalyzer.matchAnyPosition(word: word, targets: ["augh"]){
                    addUrl(url: "https://www.youtube.com/watch?v=m0tfFJm76hg")
                    
                }
                if LetterAnalyzer.matchAnyPosition(word: word, targets: ["ough"]){
                    addUrl(url: "https://www.youtube.com/watch?v=QAFWtKePJ80")
                }
                
                if(LetterAnalyzer.matchAnyPosition(word: word, targets: ["ou","ow"])){
                    if(!LetterAnalyzer.matchAnyPosition(of: word, numberOfLetters: 4, in: ["ough"])){
                       addUrl(url: "https://www.youtube.com/watch?v=3Uz9U7YhmCw")
                    }
                }
            }
        }
        
        if BlendAnalyzer.blend(word: word){
            if LetterAnalyzer.matchBeginningLetters(word: word, targets: ["bl", "br", "cl", "cr", "dr", "fl", "fr", "gl", "dr", "pl", "sc", "sk", "sl", "sn", "sp", "st", "sw", "tr", "squ"]) || LetterAnalyzer.matchAnyPosition(word: word, targets: ["ng", "nk", "nt", "nd"]){
                addUrl(url: "https://www.youtube.com/watch?v=sYmwStHMezc")
            }
            if(LetterAnalyzer.matchBeginningLetters(word: word, targets: ["scr", "thr", "shr", "spl", "str"])){
                addUrl(url: "https://www.youtube.com/watch?v=_YfuGb8f7Jo")
            }
            if LetterAnalyzer.matchBeginningLetters(word: word, targets: ["cr", "cl", "fr", "st", "fl", "sk", "sl", "sw", "str"]) || LetterAnalyzer.matchEndingLetters(word: word, targets: ["nk"]){
                addUrl(url: "https://www.youtube.com/watch?v=sB2-mFb_O0E")
            }
        }
        
        if(ConsonantDigraphsAnalyzer.isConsonantDigraphs(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=XUoRQiZqI6E")
            if(LetterAnalyzer.matchAnyPosition(word: word, targets: ["ph"])){
                addUrl(url: "https://www.youtube.com/watch?v=M7iSFjbAg8c")
            }
        }
        
        if(WordAnalyzer.unusualConsonantPronunciation(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=xZApEBQOHSQ")
        }
        
        if(TrigraphAnalyzer.isTrigraph(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=SdKW5KuDy1c&list=PL39iO7KLUw2mDudL0VIf5yyZbBQJZ0rzA")
            if LetterAnalyzer.matchAnyPosition(word: word, targets: ["tch"]){
                addUrl(url: "https://www.youtube.com/watch?v=kibwDQpqtA4")
                addUrl(url: "https://www.youtube.com/watch?v=AqxALefV3DA")
            }
        }
        
        if(RControlledVowelsAnalyzer.isRControlledVowels(word: word)){
            addUrl(url: "https://www.youtube.com/watch?v=Q1bpT3YNN50")
            addUrl(url: "https://www.youtube.com/watch?v=eE2HFLDPPDc&list=PLfeIQSyt9YL2a6tgu8RA8bB3XS62l7l-M")
            
            if LetterAnalyzer.matchAnyPosition(word: word, targets: ["ir", "er", "ur"]){
                addUrl(url: "https://www.youtube.com/watch?v=lNJGKrs8BGA")
            }
            if LetterAnalyzer.matchAnyPosition(word: word, targets: ["or", "ar"]){
                addUrl(url: "https://www.youtube.com/watch?v=uMwCnSSMB-Q")
            }
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
