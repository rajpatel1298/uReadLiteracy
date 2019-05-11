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
        let readAnArticle = ReadXArticlesGoalModel(name: "Read an Article", date: Date(), goalType: goalType, numberOfArticles: 1)
        let read2Articles = ReadXArticlesGoalModel(name: "Read 2 Articles", date: Date(), goalType: goalType, numberOfArticles: 2)
        let read5Articles = ReadXArticlesGoalModel(name: "Read 5 Articles", date: Date(), goalType: goalType, numberOfArticles: 5)
        let readFor10Minutes = ReadXMinutesGoalModel(name: "Read for 10 Minutes", date: Date(), goalType: goalType, totalMinutes: 10)
        let readFor20Minutes = ReadXMinutesGoalModel(name: "Read for 20 minutes", date: Date(), goalType: goalType, totalMinutes: 20)
        let readFor30Minutes = ReadXMinutesGoalModel(name: "Read for 30 minutes", date: Date(), goalType: goalType, totalMinutes: 30)
        list = [readAnArticle,read2Articles,read5Articles,readFor10Minutes,readFor20Minutes,readFor30Minutes]
    }
    
    func getOnlyNewGoals()->[GoalModel]{
        var result = [GoalModel]()
        
        for goal in list{
            let readXMinutesCD:ReadXMinutesCD? = CoreDataGetter.shared.find(name: goal.name, date: goal.date, goalType: goalType, returnOnlySameDate: true)
            let readXArticlesCD:ReadXArticlesCD? = CoreDataGetter.shared.find(name: goal.name, date: goal.date, goalType: goalType, returnOnlySameDate: true)
            
            if readXMinutesCD == nil && readXArticlesCD == nil{
                let components = Calendar.current.dateComponents([.day], from: goal.date, to: Date())
                
                
                
                //if(components.day! != 0 ){
                    result.append(goal)
                //}
            }
        }
        return result
    }
}
