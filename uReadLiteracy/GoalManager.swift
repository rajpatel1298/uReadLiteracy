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
        let readXArticlesGoals:[ReadXArticlesGoalModel] = CoreDataGetter.shared.getList()
        let readXMinutesGoals:[ReadXMinutesGoalModel] = CoreDataGetter.shared.getList()
        
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
        let readXArticlesGoals:[ReadXArticlesGoalModel] = CoreDataGetter.shared.getList()
        let readXMinutesGoals:[ReadXMinutesGoalModel] = CoreDataGetter.shared.getList()
        
        var ongoingGoals = [GoalModel]()
        
        for goal in readXArticlesGoals{
            if goal.goalType == GoalType.Ongoing{
                ongoingGoals.append(goal)
            }
        }
        
        for goal in readXMinutesGoals{
            if goal.goalType == GoalType.Ongoing{
                ongoingGoals.append(goal)
            }
        }
        
        return ongoingGoals
    }
    
    func updateGoals(article:ArticleModel, showGoalComplete:@escaping (_ goal:GoalModel)->Void){
        let components = Calendar.current.dateComponents([.day,.hour,.minute], from: lastTimeUpdated, to: Date())
        
        if(components.day! == 0 && components.hour! == 0 && components.minute! < 1){
            return
        }
        
        updateReadXMinutesGoals(article: article, showGoalComplete: showGoalComplete)
        updateReadXArticlesGoals(article: article, showGoalComplete: showGoalComplete)
        
        lastTimeUpdated = Date()
    }
    
    private func updateReadXArticlesGoals(article:ArticleModel,showGoalComplete:@escaping (_ goal:GoalModel)->Void){
        DispatchQueue.main.async {
            let readXArticlesGoals:[ReadXArticlesGoalModel] = CoreDataGetter.shared.getList()
            
            for goal in readXArticlesGoals{
                if goal.isCompleted(){
                    continue
                }
                
                var articleExist = false
                for articleItem in goal.articles{
                    if articleItem.equal(article: article){
                        articleExist = true
                    }
                }
                
                if !articleExist{
                    goal.articles.append(article)
                    
                    if  goal.isCompleted(){
                        showGoalComplete(goal)
                    }
                    CoreDataUpdater.shared.save(goalModel: goal)
                }
            }
        }
        
    }
    
    private func updateReadXMinutesGoals(article:ArticleModel,showGoalComplete:@escaping (_ goal:GoalModel)->Void){
        DispatchQueue.main.async {
            let readXMinutesGoals:[ReadXMinutesGoalModel] = CoreDataGetter.shared.getList()
            for goal in readXMinutesGoals{
                if goal.isCompleted(){
                    continue
                }
                
                goal.minutesRead += Int(article.timeSpent)
                if(goal.minutesRead > goal.totalMinutes){
                    goal.minutesRead = goal.totalMinutes
                }
                
                if  goal.isCompleted(){
                    showGoalComplete(goal)
                }
                
                CoreDataUpdater.shared.save(goalModel: goal)
            }
        }

    }
}
