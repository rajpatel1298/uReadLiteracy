//
//  ReadingSource.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/27/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class ReadingSource{
    let name:String
    let difficulty:ReadingDifficulty
    
    init(name:String, difficulty:ReadingDifficulty){
        self.name = name
        self.difficulty = difficulty
    }
}
