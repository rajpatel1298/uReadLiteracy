//
//  DictionaryManager.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/17/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class DictionaryManager{
    static let shared = DictionaryManager()
    
    func getDictionaryWord(word:String, completion:@escaping (DictionaryWord?)->Void){
        
        let url = "https://googledictionaryapi.eu-gb.mybluemix.net/?define=\(word)"
        
        URLService.shared.get(urlString: url) { (data) in
            guard let data = data else{
                completion(nil)
                return
            }
            do{
                let result = try JSONDecoder().decode(DictionaryWord.self, from: data)
                completion(result)
            }
            catch{
                print(error)
                completion(nil)
            }
            
        }
    }
    
    /*func getDefinition(from word:DictionaryWord)->String{
        var definition = ""
        
        let meaning = word.meaning
        
        if let nouns = meaning.noun{
            if nouns.count == 1{
                definition.append(contentsOf: nouns[0].definition)
                definition = addDotToEndOfSetence(string: definition)
            }
            else{
                for x in 1...nouns.count{
                    definition.append(contentsOf: nouns[x-1].definition)
                    definition = addDotToEndOfSetence(string: definition)
                }
            }
        }
        
        if let verbs = meaning.verb{
            if verbs.count == 1{
                definition.append(contentsOf: verbs[0].definition)
                definition = addDotToEndOfSetence(string: definition)
            }
            else{
                for x in 1...verbs.count{
                    definition.append(contentsOf: verbs[x-1].definition)
                    definition = addDotToEndOfSetence(string: definition)
                }
            }
        }
        
        if let adjectives = meaning.adjective{
            if adjectives.count == 1{
                definition.append(contentsOf: adjectives[0].definition)
                definition = addDotToEndOfSetence(string: definition)
            }
            else{
                for x in 1...adjectives.count{
                    definition.append(contentsOf: adjectives[x-1].definition)
                    definition = addDotToEndOfSetence(string: definition)
                }
            }
        }
        
        return definition
    }*/
    
    private func addDotToEndOfSetence(string:String)->String{
        var string = string
        string.append(contentsOf: ". ")
        return string
    }
    
    func getTitles(from word:DictionaryWord)->[String]{
        
        var titles = [String]()
        titles.append(word.word)
        
        let meaning = word.meaning
        
        if let nouns = meaning.noun{
            for x in 0...(nouns.count-1){
                titles.append(nouns[x].definition)
            }
        }
        
        if let verbs = meaning.verb{
            for x in 0...(verbs.count-1){
                titles.append(verbs[x].definition)
            }
        }
        
        if let adjectives = meaning.adjective{
            for x in 0...(adjectives.count-1){
                titles.append(adjectives[x].definition)
            }
        }
        
        return titles
    }
}
