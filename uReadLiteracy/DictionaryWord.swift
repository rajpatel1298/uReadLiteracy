//
//  DictionaryWord.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/17/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

struct DictionaryWord:Decodable{
    let word:String
    let phonetic:String?
    let meaning:DictionaryMeaning
    let pronunciation:String?
    let origin:String?
}
