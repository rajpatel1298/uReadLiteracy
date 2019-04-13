//
//  PrefixSuffixAnalyzer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/10/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class PrefixSuffixAnalyzer{
    static func prefixSuffix(word:String)->Bool{
        return prefix(word:word) || suffix(word:word)
    }
    
    static func prefix(word:String)->Bool{
        let prefixes = ["re", "anti", "bio", "trans","aqua", "ami", "bio", "hemo", "geo", "vita", "pre", "anti", "poly", "homo"]
        
        for prefix in prefixes{
            if(word.hasPrefix(prefix)){
                return true
            }
        }

        return false
    }
    static func suffix(word:String)->Bool{
        let suffixes = ["ly", "ed", "ing", "er", "ment", "cian", "sion","tion","ure", "ish", "ology", "ism", "cide", "or", "er", "phobia", "kenisis"]
        
        for suffix in suffixes{
            if(word.hasSuffix(suffix)){
                return true
            }
        }
        return false
    }
}
