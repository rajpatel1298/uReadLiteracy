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
    
    static func getAll()->[String]{
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
        
        var videoHtmlList = [String]()
        for url in urls{
            videoHtmlList.append(YoutubeLink(url: url).getHtml())
        }
        return videoHtmlList
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
        var videoHtmlList = [String]()
        
        if(shortE()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=H2aqKNc00Vc").getHtml())
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=UQkPO3qpUCg").getHtml())
        }
        
        if(videoHtmlList.count > 0){
            wordDetails.append(WordAnalysisDetail(title:title, detail: "This word has a short vowel sound.  When words or syllables have a consonant-vowel-consonant pattern, they generally have a short vowel sound.  When e is the vowel, the short vowel sound is /eh/ as in bed.", videoHtmlList: videoHtmlList))
        }
    }
    
    //Short e: c-e-c pattern
    private func shortE()->Bool{
        return LetterAnalyzer.consonantLetterConsonant(word: word, letter: "e")
    }
    
    //MARK: New Detail
    
    private func addShortU(){
        var videoHtmlList = [String]()
        
        if(shortU()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=17lyXMgkk9E").getHtml())
        }
        
        if(videoHtmlList.count > 0){
            wordDetails.append(WordAnalysisDetail(title:title, detail: "When words or syllables have a consonant-vowel-consonant pattern, they generally have a short vowel sound.  When u is the vowel, the short vowel sound is /uh/ as in cut.  Note that there are other ways to make the short u sound that you will learn about in other videos", videoHtmlList: videoHtmlList))
        }
    }
    
    //Short u: c-u-c
    private func shortU()->Bool{
        return LetterAnalyzer.consonantLetterConsonant(word: word, letter: "u")
    }
    
    //MARK: New Detail
    
    private func addShortO(){
        var videoHtmlList = [String]()

        if(shortO()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=4QRop-G9hw8").getHtml())
        }
        
        if(videoHtmlList.count > 0){
            wordDetails.append(WordAnalysisDetail(title:title, detail: "This word has a short vowel sound.  When words or syllables have a consonant-vowel-consonant pattern, they generally have a short vowel sound.  When o is the vowel, the short vowel sound is /ah/ as in mop.", videoHtmlList: videoHtmlList))
        }
    }
    
    //Short o: c-o-c
    private func shortO()->Bool{
        return LetterAnalyzer.consonantLetterConsonant(word: word, letter: "o")
    }
    
    // MARK: New Detail
    
    private func addShortI(){
        var videoHtmlList = [String]()
        
        if(shortI()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=ZY1ZRuEcah4").getHtml())
        }
        
        if(videoHtmlList.count > 0){
            wordDetails.append(WordAnalysisDetail(title:title, detail: "This word has a short vowel sound.  When words or syllables have a consonant-vowel-consonant pattern, they generally have a short vowel sound.  When i is the vowel, the short vowel sound is /ih/ as in pin.", videoHtmlList: videoHtmlList))
        }
    }
    
    //Short i: c-i-c
    private func shortI()->Bool{
        return LetterAnalyzer.consonantLetterConsonant(word: word, letter: "i")
    }
    
    // MARK: New Detail
    
    private func addShortA(){
        var videoHtmlList = [String]()
        
        if(shortA()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=UQkPO3qpUCg").getHtml())
        }
        
        if(videoHtmlList.count > 0){
            wordDetails.append(WordAnalysisDetail(title:title, detail: "This word has a short vowel sound.  When words or syllables have a consonant-vowel-consonant pattern, they generally have a short vowel sound.  When a is the vowel, the short vowel sound is /a/ as in cap.", videoHtmlList: videoHtmlList))
        }
    }
    
    //Short a: c-a-c
    private func shortA()->Bool{
        return LetterAnalyzer.consonantLetterConsonant(word: word, letter: "a")
    }
}
