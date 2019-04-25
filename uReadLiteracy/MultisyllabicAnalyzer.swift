//
//  MultisyllabicAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/12/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class MultisyllabicAnalyzer{
    private var wordDetails = [WordAnalysisDetail]()
    private var word = ""
    
    func getDetails(word:String)->[WordAnalysisDetail]{
        wordDetails.removeAll()
        self.word = word
        
        var urlRequestList = [URLRequest]()
        
        if(multisyllabic()){
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=vNR2xyrZVv0"))
            urlRequestList.append(StringToUrlRequest.get(url: "https://www.youtube.com/watch?v=GDW0fwQoacc"))
        }
        
        if(urlRequestList.count > 0){
            let detail = WordAnalysisDetail(detail: "This is a long word; this is called a multisyllabic word which means more than one syllable.  Long words, words with more than one syllable, can be hard to read, but if you learn the rules for breaking them up into parts, this will help.  Once you break a word into its parts (syllables), you should be able to use many other “learn more” videos to understand how to pronounce those parts.", urlRequests: urlRequestList)
            
            
            wordDetails.append(detail)
        }
        
        return wordDetails
    }
    
    private func multisyllabic()->Bool{
        //calculate multisyllabic words
        var counter = 0
        
        for char in word.enumerated() {
            if counter == 1 && LetterAnalyzer.isVowel(letter: char.element) {
                return true
            }
            else if (counter == 1 && !LetterAnalyzer.isVowel(letter: char.element)) {
                //continue
            }
            else if (counter == 0 && LetterAnalyzer.isVowel(letter: char.element)){
                counter = 1
            }
            else {
                //do nothing
            }
        }
        return false
    }
}
