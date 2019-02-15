//
//  OngoingGoalGetter.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/14/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class OngoingGoalGetter{
    private let list:[GoalModel]
    private let goalType:GoalType = .Ongoing
    
    static let shared = OngoingGoalGetter()
    
    init() {
        let read50Articles = ReadXArticlesGoalModel(name: "Read 50 Articles", date: Date(), goalType: goalType, numberOfArticles: 50)
        let readFor120Minutes = ReadXMinutesGoalModel(name: "Read for 2 hours", date: Date(), goalType: goalType, totalMinutes: 120)
        list = [read50Articles,readFor120Minutes]
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
