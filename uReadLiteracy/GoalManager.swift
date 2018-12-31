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
    static func getDailyGoals()->[GoalModel]{
        let readXArticlesGoals = ReadXArticlesGoalModel.getModels()
        let readXMinutesGoals = ReadXMinutesGoalModel.getModels()
        
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
    
    static func getOngoingGoals()->[GoalModel]{
        let readXArticlesGoals = ReadXArticlesGoalModel.getModels()
        let readXMinutesGoals = ReadXMinutesGoalModel.getModels()
        
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
}
