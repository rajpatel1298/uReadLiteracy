//
//  ReadXArticlesGoalModel.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/25/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation

class ReadXStoriesWeeklyGoal:DailyGoalModel{
    var numOfStories = 0
    
    init(numOfStories:Int, date: Date) {
        self.numOfStories = numOfStories
        if(numOfStories == 1){
            super.init(name: "Read 1 Story Weekly", date: date, type: .ReadXStories)
        }
        else{
            super.init(name: "Read \(numOfStories) Stories Weekly", date: date, type: .ReadXStories)
        }
        
        
    }
}
