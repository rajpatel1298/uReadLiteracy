//
//  DictionaryVerb.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/17/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

struct DictionaryVerb:Decodable{
    let definition:String
    let example:String?
    let synonyms:[String]?
}
