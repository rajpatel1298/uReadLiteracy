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
        let read5Articles = ReadXArticlesGoalModel(name: "Read 5 Articles", date: Date(), goalType: goalType, numberOfArticles: 5)
        let read10Articles = ReadXArticlesGoalModel(name: "Read 10 Articles", date: Date(), goalType: goalType, numberOfArticles: 10)
        let read15Articles = ReadXArticlesGoalModel(name: "Read 15 Articles", date: Date(), goalType: goalType, numberOfArticles: 15)
        let readFor1Hour = ReadXMinutesGoalModel(name: "Read for 1 hour", date: Date(), goalType: goalType, totalMinutes: 60)
        let readFor2Hours = ReadXMinutesGoalModel(name: "Read for 2 hours", date: Date(), goalType: goalType, totalMinutes: 120)
        let readFor3Hours = ReadXMinutesGoalModel(name: "Read for 3 hours", date: Date(), goalType: goalType, totalMinutes: 180)
        let readFor4Hours = ReadXMinutesGoalModel(name: "Read for 4 hours", date: Date(), goalType: goalType, totalMinutes: 240)
        let readFor5Hours = ReadXMinutesGoalModel(name: "Read for 5 hours", date: Date(), goalType: goalType, totalMinutes: 300)
        list = [read5Articles,read10Articles,read15Articles,readFor1Hour,readFor2Hours,readFor3Hours,readFor4Hours,readFor5Hours]
    }
    
    func getOnlyNewGoals()->[GoalModel]{
        var result = [GoalModel]()
        
        for goal in list{
            let readXMinutesCD:ReadXMinutesCD? = CoreDataGetter.shared.find(name: goal.name, date: goal.date, goalType: goalType)
            let readXArticlesCD:ReadXArticlesCD? = CoreDataGetter.shared.find(name: goal.name, date: goal.date, goalType: goalType)
            
            if readXMinutesCD == nil && readXArticlesCD == nil{
                result.append(goal)
            }
        }
        return result
    }
}
