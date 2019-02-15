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
            if let _:ReadXMinutesCD = CoreDataGetter.shared.find(name: goal.name, date: goal.date, goalType: goalType){
                result.append(goal)
            }
            if let _:ReadXArticlesCD = CoreDataGetter.shared.find(name: goal.name, date: goal.date, goalType: goalType){
                result.append(goal)
            }
        }
        return result
    }
}
