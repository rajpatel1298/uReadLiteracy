//
//  SocialMediaQuote.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/23/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class SocialMediaQuote{
    static func get(goal:GoalModel)->String{
        print("I have completed my goal, \"\(goal.getDescription())\". Join me on Uread!")
        return "I have completed my goal, \"\(goal.getDescription())\". Join me on Uread!"
    }
}
