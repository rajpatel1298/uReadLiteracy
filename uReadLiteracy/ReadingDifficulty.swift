//
//  ReadingDifficulty.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/28/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

enum ReadingDifficulty:String,CaseIterable{
    case Level1 = "Level 1"
    case Level2 = "Level 2"
    case Level3 = "Level 3"
    
    init(level:Int){
        switch(level){
        case 1:
            self = .Level1
            break
        case 2:
            self = .Level2
            break
        case 3:
            self = .Level3
            break
        default:
            self = .Level1
            break
        }
    }
}
