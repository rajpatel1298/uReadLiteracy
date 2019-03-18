//
//  DictionaryMeaning.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/17/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

struct DictionaryMeaning:Decodable{
    let noun:[DictionaryNoun]?
    let verb:[DictionaryVerb]?
    let adjective:[DictionaryAdjective]?
}
