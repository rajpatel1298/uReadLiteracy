//
//  WordAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/9/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class WordAnalyzer{
    private static let longVowelAnalyzer = LongVowelSoundAnalyzer()
    private static let shortVowelAnalyzer = ShortVowelSoundAnalyzer()
    private static let prefixsuffixAnalyzer = PrefixSuffixAnalyzer()
    private static let multisyllabicAnalyzer = MultisyllabicAnalyzer()
    private static let otherCasesWordAnalyzer = OtherCasesWordAnalyzer()
    private static let blendAnalyzer = BlendAnalyzer()
    private static let consonantDigraphsAnalyzer = ConsonantDigraphsAnalyzer()
    private static let trigraphAnalyzer = TrigraphAnalyzer()
    private static let rControlledVowelsAnalyzer = RControlledVowelsAnalyzer()
    
    static func getDetails(helpWord:HelpWordModel)->[WordAnalysisDetail]{
        let word = helpWord.word
        
        var wordDetails = [WordAnalysisDetail]()
        wordDetails.append(contentsOf: longVowelAnalyzer.getDetails(word: word))
        wordDetails.append(contentsOf: shortVowelAnalyzer.getDetails(word: word))
        wordDetails.append(contentsOf: prefixsuffixAnalyzer.getDetails(word: word))
        wordDetails.append(contentsOf: multisyllabicAnalyzer.getDetails(word: word))
        wordDetails.append(contentsOf: otherCasesWordAnalyzer.getDetails(word: word))
        wordDetails.append(contentsOf: blendAnalyzer.getDetails(word: word))
        wordDetails.append(contentsOf: consonantDigraphsAnalyzer.getDetails(word: word))
        wordDetails.append(contentsOf: rControlledVowelsAnalyzer.getDetails(word: word))
        
        return wordDetails
    }
}
