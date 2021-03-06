//
//  RControlledVowelsAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/12/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class RControlledVowelsAnalyzer{
    private var wordDetails = [WordAnalysisDetail]()
    private var word = ""
    private let title:String
    
    init(title:String){
        self.title = title
    }
    
    static func getAll()->[String]{
        let urls = ["https://www.youtube.com/watch?v=Q1bpT3YNN50",
                    "https://www.youtube.com/watch?v=eE2HFLDPPDc&list=PLfeIQSyt9YL2a6tgu8RA8bB3XS62l7l-M",
                    "https://www.youtube.com/watch?v=lNJGKrs8BGA",
            "https://www.youtube.com/watch?v=uMwCnSSMB-Q"
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
        
        addRControlledVowels()
        return wordDetails
    }
    
    // MARK: New Detail
    
    private func addRControlledVowels(){
        var videoHtmlList = [String]()
        
        if(isRControlledVowels()){
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=Q1bpT3YNN50").getHtml())
            videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=eE2HFLDPPDc&list=PLfeIQSyt9YL2a6tgu8RA8bB3XS62l7l-M").getHtml())
            
            if LetterAnalyzer.matchAnyPosition(word: word, targets: ["ir", "er", "ur"]){
                videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=lNJGKrs8BGA").getHtml())
            }
            if LetterAnalyzer.matchAnyPosition(word: word, targets: ["or", "ar"]){
                videoHtmlList.append(YoutubeLink(url: "https://www.youtube.com/watch?v=uMwCnSSMB-Q").getHtml())
            }
        }
        
        if(videoHtmlList.count > 0){
            wordDetails.append(WordAnalysisDetail(title: title, detail: "This word has an “r controlled vowel.  When r comes after a vowel it sometimes changes the sound of the vowel so that it is neither a long or a short vowel sound.  This is called an “r controlled vowel”. The way the r changes the vowel sound is pretty much the same every time it is in “control” so it’s important to learn to recognize and know the sound of the r controlled vowel.", videoHtmlList: videoHtmlList))
        }
    }
    
    private func isRControlledVowels()->Bool{
        if(LetterAnalyzer.matchAnyPosition(word: word, targets: ["ir", "er", "ur","or", "ar"])){
            return true
        }
        return false
    }
}
