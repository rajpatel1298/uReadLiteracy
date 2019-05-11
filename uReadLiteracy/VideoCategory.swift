//
//  VideoCategory.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/30/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

enum VideoCategory:String,CaseIterable{
    case LongVowels = "Long Vowel Sounds"
    case ShortVowels = "Short Vowel Sounds"
    case PrefixSuffix = "Prefixes and Suffixes"
    case Multisyllabic = "Multisyllabic Words"
    case ConsonantBlends = "Consonant Blends"
    case ConsonantDigraphs = "Consonant Digraphs"
    case Trigraph = "Trigraph"
    case RControlledVowels = "R Controlled Vowels"
    case SightWord = "Sight Words"
    case Exceptions = "Weird Words and Exceptions"
}
