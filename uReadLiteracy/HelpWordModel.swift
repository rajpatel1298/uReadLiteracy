//
//  HelpWordModel.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/22/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import CoreData

class HelpWordModel{
    private let word:String
    
    private var beginningDifficult:Bool!
    private var endingDifficult:Bool!
    private var blendDifficult:Bool!
    private var multisyllabicDifficult:Bool!
    
    
    init(word:String){
        self.word = word
    }
    init(word:String,beginningDifficult:Bool,endingDifficult:Bool,blendDifficult:Bool,multisyllabicDifficult:Bool){
        self.word = word
        self.beginningDifficult = beginningDifficult
        self.endingDifficult = endingDifficult
        self.blendDifficult = blendDifficult
        self.multisyllabicDifficult = multisyllabicDifficult
    }
    
    func getWord()->String{
        return word
    }
    
    private func beginningDifficult(word:String)->Bool{
        let beginnings = ["bl", "br", "ch", "ci", "cl", "cr", "dis", "dr", "dw", "ex", "fl", "fr", "gl", "gr", "in","kn", "ph", "pl", "pr", "psy", "re", "sc", "sh", "shr", "sk", "sl","sm", "sn", "sp", "spr", "st", "str", "sw", "th", "thr", "tr", "tw", "un", "wh", "wr","eigh"]
        
        //calculate number of difficult beginning words
        for beg in beginnings{
            let currBeg = beg
            if(word.hasPrefix(currBeg) == true){
                return true
            }
        }
        
        return false
    }
    
    private func endingDifficult(word:String)->Bool{
        let endings = ["augh", "cial", "cian", "ck", "dge", "ed", "ful", "gh", "ght", "ing", "ious", "ld", "le", "lf", "lk", "lm", "lp", "lt", "ly", "ment", "mp", "nce", "nch", "nd", "nk", "nse", "nt","ough","over", "psy", "pt", "tien", "tion", "ture"]
        //calculate number of difficult ending words
        for end in endings {
            let currEnd = end;
            if(word.hasSuffix(currEnd) == true){
                return true
            }
        }
        return false
    }
    
    private func blendDifficult(word:String)->Bool{
        //calculate word blends
        var counter = 0;
        //   string = string.lowercased()
        for char in word.enumerated() {
            if ((counter == 1) && (isVowel(letter: char.element) || (char.element == "y" || char.element == "w"))){
                return true
            } else if(isVowel(letter: char.element)){
                counter += 1
            } else {
                counter = 0
            }
        }
        return false
    }
    
    private func multisyllabicDifficult(word:String)->Bool{
        //calculate multisyllabic words
        var counter = 0
        
        for char in word.enumerated() {
            if counter == 1 && isVowel(letter: char.element) {
                return true
            }
            else if (counter == 1 && !isVowel(letter: char.element)) {
                //continue
            }
            else if (counter == 0 && isVowel(letter: char.element)){
                counter = 1
            }
            else {
                //do nothing
            }
        }
        return false
    }
    
    private func isVowel(letter: Character) -> Bool{
        if(letter == "a" || letter == "e" || letter == "i" || letter == "o" || letter == "u"){
            return true
        }
        return false
    }
    
    func save(){
        let managedContext = CoreDataHelper.sharedInstance.getManagedContext()
        let wordEntity = NSEntityDescription.entity(forEntityName: "HelpWord", in: managedContext)!
        
        let wordObject = NSManagedObject(entity: wordEntity, insertInto: managedContext)
        
        getWordDifficultyIfNil()
    
        wordObject.setValue(word, forKeyPath: "word")
        wordObject.setValue(beginningDifficult, forKeyPath: "beginningDifficult")
        wordObject.setValue(endingDifficult, forKeyPath: "endingDifficult")
        wordObject.setValue(blendDifficult, forKeyPath: "blendDifficult")
        wordObject.setValue(multisyllabicDifficult, forKeyPath: "multisyllabicDifficult")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func getWordList()->[HelpWordModel]{
        let managedContext = CoreDataHelper.sharedInstance.getManagedContext()
        let wordFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "HelpWord")
        
        let words = try! managedContext.fetch(wordFetch) as! [HelpWord]
        
        var list = [HelpWordModel]()
        
        for word in words{
            let w = HelpWordModel(word: word.word!, beginningDifficult: word.beginningDifficult, endingDifficult: word.endingDifficult, blendDifficult: word.blendDifficult, multisyllabicDifficult: word.multisyllabicDifficult)
            list.append(w)
        }
        
        return list
    }
    
    private func getWordDifficultyIfNil(){
        if(self.beginningDifficult == nil){
            beginningDifficult = self.beginningDifficult(word: word)
        }
        if(self.endingDifficult == nil){
            endingDifficult = self.endingDifficult(word: word)
        }
        if(self.blendDifficult == nil){
            blendDifficult = self.blendDifficult(word: word)
        }
        if(self.multisyllabicDifficult == nil){
            multisyllabicDifficult = self.multisyllabicDifficult(word: word)
        }
    }
    
    func getDescription()->String{
        getWordDifficultyIfNil()
        
        var string = "The word: \(word) might be difficult because of:\n"
        
        if(beginningDifficult){
            string.append("- Its beginning\n")
        }
        if(endingDifficult){
            string.append("- Its ending\n")
        }
        if(blendDifficult){
            string.append("- It has a blend\n")
        }
        if(multisyllabicDifficult){
            string.append("- It is multisyllabic\n")
        }
        
        string.append("\nWatch these videos to learn more.")
        
        return string
    }
    
    func isBeginningDifficult()->Bool{
        return beginningDifficult
    }
    
    func isEndingDifficult()->Bool{
        return endingDifficult
    }
    func isBlendDifficult()->Bool{
        return blendDifficult
    }
    
    func isMultisyllabicDifficult()->Bool{
        return multisyllabicDifficult
    }
}