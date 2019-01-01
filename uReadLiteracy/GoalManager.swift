//
//  GoalManager.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 12/30/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import CoreData

class GoalManager{
    static var shared = GoalManager()
    private var lastTimeUpdated = Date()
    
    func getDailyGoals()->[GoalModel]{
        let readXArticlesGoals:[ReadXArticlesGoalModel] = ReadXArticlesGoalModel.getModels()
        let readXMinutesGoals:[ReadXMinutesGoalModel] = ReadXMinutesGoalModel.getModels()
        
        var dailyGoals = [GoalModel]()
        
        for goal in readXArticlesGoals{
            if goal.goalType == GoalType.Daily{
                dailyGoals.append(goal)
            }
        }
        
        for goal in readXMinutesGoals{
            if goal.goalType == GoalType.Daily{
                dailyGoals.append(goal)
            }
        }

        return dailyGoals
    }
    
    func getOngoingGoals()->[GoalModel]{
        let readXArticlesGoals:[ReadXArticlesGoalModel] = ReadXArticlesGoalModel.getModels()
        let readXMinutesGoals:[ReadXMinutesGoalModel] = ReadXMinutesGoalModel.getModels()
        
        var dailyGoals = [GoalModel]()
        
        for goal in readXArticlesGoals{
            if goal.goalType == GoalType.Ongoing{
                dailyGoals.append(goal)
            }
        }
        
        for goal in readXMinutesGoals{
            if goal.goalType == GoalType.Ongoing{
                dailyGoals.append(goal)
            }
        }
        
        return dailyGoals
    }
    
    func updateGoals(article:ArticleModel){
        let components = Calendar.current.dateComponents([.day,.hour,.minute], from: lastTimeUpdated, to: Date())
        
        
        if(components.day! == 0 && components.hour! == 0 && components.minute! < 2){
            return
        }
        
        let readXArticlesGoals:[ReadXArticlesGoalModel] = ReadXArticlesGoalModel.getModels()
        let readXMinutesGoals:[ReadXMinutesGoalModel] = ReadXMinutesGoalModel.getModels()
        
        for goal in readXArticlesGoals{
            var articleExist = false
            for articleItem in goal.articles{
                if articleItem.equal(article: article){
                    articleExist = true
                }
            }
            
            if !articleExist{
                goal.articles.append(article)
                goal.save()
            }
        }
        
        for goal in readXMinutesGoals{
            goal.minutesRead = goal.minutesRead + article.timeReadThisTimeInMinutes()
            if(goal.minutesRead > goal.totalMinutes){
                goal.minutesRead = goal.totalMinutes
            }
            goal.save()
        }
        
        lastTimeUpdated = Date()
    }
}
