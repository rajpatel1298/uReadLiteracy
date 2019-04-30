//
//  ShortVowelSoundAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/10/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class ShortVowelSoundAnalyzer{
    
    private var wordDetails = [WordAnalysisDetail]()
    private var word = ""
    private let title:String
    
    init(title:String){
        self.title = title
    }
    
    static func getAll()->[URLRequest]{
        let urls = ["https://www.youtube.com/watch?v=H2aqKNc00Vc",
                    "https://www.youtube.com/watch?v=UQkPO3qpUCg",
                    //
            "https://www.youtube.com/watch?v=17lyXMgkk9E",
            //
            "https://www.youtube.com/watch?v=4QRop-G9hw8",
            //
            "https://www.youtube.com/watch?v=ZY1ZRuEcah4",
            //
            "https://www.youtube.com/watch?v=UQkPO3qpUCg"]
        
        var urlRequestList = [URLRequest]()
        for url in urls{
            urlRequestList.append(StringToUrlRequest.get(url: url))
        }
        return urlRequestList
    }
    
    
    func getDetails(word:String)->[WordAnalysisDetail]{
        wordDetails.removeAll()
        self.word = word
        
        addShortE()
        addShortU()
        addShortO()
        addShortI()
        addShortA()
        
        return wordDetails
    }
    
    
    
    
    // ----------------------------------------------------------------
    // MARK: New Detail
    
    private func addShortE(){
        var urlRequestList = [URLRequest]()
        
        if(shortE()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=H2aqKNc00Vc"))
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=UQkPO3qpUCg"))
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title:title, detail: "This word has a short vowel sound.  When words or syllables have a consonant-vowel-consonant pattern, they generally have a short vowel sound.  When e is the vowel, the short vowel sound is /eh/ as in bed.", urlRequests: urlRequestList))
        }
    }
    
    //Short e: c-e-c pattern
    private func shortE()->Bool{
        return LetterAnalyzer.consonantLetterConsonant(word: word, letter: "e")
    }
    
    //MARK: New Detail
    
    private func addShortU(){
        var urlRequestList = [URLRequest]()
        
        if(shortU()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=17lyXMgkk9E"))
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title:title, detail: "When words or syllables have a consonant-vowel-consonant pattern, they generally have a short vowel sound.  When u is the vowel, the short vowel sound is /uh/ as in cut.  Note that there are other ways to make the short u sound that you will learn about in other videos", urlRequests: urlRequestList))
        }
    }
    
    //Short u: c-u-c
    private func shortU()->Bool{
        return LetterAnalyzer.consonantLetterConsonant(word: word, letter: "u")
    }
    
    //MARK: New Detail
    
    private func addShortO(){
        var urlRequestList = [URLRequest]()

        if(shortO()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=4QRop-G9hw8"))
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title:title, detail: "This word has a short vowel sound.  When words or syllables have a consonant-vowel-consonant pattern, they generally have a short vowel sound.  When o is the vowel, the short vowel sound is /ah/ as in mop.", urlRequests: urlRequestList))
        }
    }
    
    //Short o: c-o-c
    private func shortO()->Bool{
        return LetterAnalyzer.consonantLetterConsonant(word: word, letter: "o")
    }
    
    // MARK: New Detail
    
    private func addShortI(){
        var urlRequestList = [URLRequest]()
        
        if(shortI()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=ZY1ZRuEcah4"))
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title:title, detail: "This word has a short vowel sound.  When words or syllables have a consonant-vowel-consonant pattern, they generally have a short vowel sound.  When i is the vowel, the short vowel sound is /ih/ as in pin.", urlRequests: urlRequestList))
        }
    }
    
    //Short i: c-i-c
    private func shortI()->Bool{
        return LetterAnalyzer.consonantLetterConsonant(word: word, letter: "i")
    }
    
    // MARK: New Detail
    
    private func addShortA(){
        var urlRequestList = [URLRequest]()
        
        if(shortA()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=UQkPO3qpUCg"))
        }
        
        if(urlRequestList.count > 0){
            wordDetails.append(WordAnalysisDetail(title:title, detail: "This word has a short vowel sound.  When words or syllables have a consonant-vowel-consonant pattern, they generally have a short vowel sound.  When a is the vowel, the short vowel sound is /a/ as in cap.", urlRequests: urlRequestList))
        }
    }
    
    //Short a: c-a-c
    private func shortA()->Bool{
        return LetterAnalyzer.consonantLetterConsonant(word: word, letter: "a")
    }
}
