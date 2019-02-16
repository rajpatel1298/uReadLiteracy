//
//  DailyGoals.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/14/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class DailyGoalsGetter{
    private let list:[GoalModel]
    private let goalType:GoalType = .Daily
    
    static let shared = DailyGoalsGetter()
    
    init() {
        let read10Articles = ReadXArticlesGoalModel(name: "Read 10 Articles", date: Date(), goalType: goalType, numberOfArticles: 10)
        let readFor30Minutes = ReadXMinutesGoalModel(name: "Read for 30 minutes", date: Date(), goalType: goalType, totalMinutes: 30)
        list = [read10Articles,readFor30Minutes]
    }
    
    func getOnlyNewGoals()->[GoalModel]{
        var result = [GoalModel]()
        
        for goal in list{
            let readXMinutesCD:ReadXMinutesCD? = CoreDataGetter.shared.find(name: goal.name, date: goal.date, goalType: goalType)
            let readXArticlesCD:ReadXArticlesCD? = CoreDataGetter.shared.find(name: goal.name, date: goal.date, goalType: goalType)
            
            if readXMinutesCD == nil && readXMinutesCD == nil{
                let components = Calendar.current.dateComponents([.day], from: goal.date, to: Date())
                
                if(components.day! != 0 ){
                    result.append(goal)
                }
            }
        }
        return result
    }
}
