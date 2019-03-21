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
    
    func getTitlesWithDefinition(from word:DictionaryWord)->[String:String]{
        var titleWithDefinition = [String:String]()
        titleWithDefinition[word.word] = word.word
        
        let meaning = word.meaning
        
        if let nouns = meaning.noun{
            if nouns.count == 1{
                titleWithDefinition["Noun"] = nouns[0].definition
            }
            else{
                for x in 1...nouns.count{
                    titleWithDefinition["Noun \(x)"] = nouns[x-1].definition
                }
            }
        }
        
        if let verbs = meaning.verb{
            if verbs.count == 1{
                titleWithDefinition["Verb"] = verbs[0].definition
            }
            else{
                for x in 1...verbs.count{
                    titleWithDefinition["Verb \(x)"] = verbs[x-1].definition
                }
            }
        }
        
        if let adjectives = meaning.adjective{
            if adjectives.count == 1{
                titleWithDefinition["Adjective"] = adjectives[0].definition
            }
            else{
                for x in 1...adjectives.count{
                    titleWithDefinition["Adjective \(x)"] = adjectives[x-1].definition
                }
            }
        }
        
        return titleWithDefinition
    }
    
    func getTitles(from word:DictionaryWord)->[String]{
        
        var titles = [String]()
        titles.append(word.word)
        
        let meaning = word.meaning
        
        if let nouns = meaning.noun{
            if nouns.count == 1{
                titles.append("Noun")
            }
            else{
                for x in 1...nouns.count{
                    titles.append("Noun \(x)")
                }
            }
        }
        
        if let verbs = meaning.verb{
            if verbs.count == 1{
                titles.append("Verb")
            }
            else{
                for x in 1...verbs.count{
                    titles.append("Verb \(x)")
                }
            }
        }
        
        if let adjectives = meaning.adjective{
            if adjectives.count == 1{
                titles.append("Adjective")
            }
            else{
                for x in 1...adjectives.count{
                    titles.append("Adjective \(x)")
                }
            }
        }
        
        return titles
    }
}
