//
//  WordAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/9/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class WordAnalyzer{
    private static let longVowelAnalyzer = LongVowelSoundAnalyzer(title: "Long Vowel Sounds")
    private static let shortVowelAnalyzer = ShortVowelSoundAnalyzer(title: "Short Vowel Sounds")
    private static let prefixsuffixAnalyzer = PrefixSuffixAnalyzer(title: "Prefixes and Suffixes")
    private static let multisyllabicAnalyzer = MultisyllabicAnalyzer(title: "Multisyllabic Words")
    private static let otherCasesWordAnalyzer = OtherCasesWordAnalyzer(title: "Weird Words and Exceptions")
    private static let blendAnalyzer = BlendAnalyzer(title: "Consonant Blends")
    private static let consonantDigraphsAnalyzer = ConsonantDigraphsAnalyzer(title: "Consonant Digraphs")
    private static let trigraphAnalyzer = TrigraphAnalyzer(title: "Trigraph")
    private static let rControlledVowelsAnalyzer = RControlledVowelsAnalyzer(title: "R Controlled Vowels")
    private static let sightWordAnalyzer = SightWordAnalyzer(title: "Sight Words")
    
    static func getDetails(helpWord:HelpWordModel)->[WordAnalysisDetail]{
        let word = helpWord.word.lowercased()
        
        var wordDetails = [WordAnalysisDetail]()
        wordDetails.append(contentsOf: longVowelAnalyzer.getDetails(word: word))
        wordDetails.append(contentsOf: shortVowelAnalyzer.getDetails(word: word))
        wordDetails.append(contentsOf: prefixsuffixAnalyzer.getDetails(word: word))
        wordDetails.append(contentsOf: multisyllabicAnalyzer.getDetails(word: word))
        wordDetails.append(contentsOf: otherCasesWordAnalyzer.getDetails(word: word))
        wordDetails.append(contentsOf: blendAnalyzer.getDetails(word: word))
        wordDetails.append(contentsOf: consonantDigraphsAnalyzer.getDetails(word: word))
        wordDetails.append(contentsOf: rControlledVowelsAnalyzer.getDetails(word: word))
        wordDetails.append(contentsOf: sightWordAnalyzer.getDetails(word: word))
        
        return wordDetails
    }
}
