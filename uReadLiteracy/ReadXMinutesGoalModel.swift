//
//  ReadXMinutesGoalModel.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 12/30/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import CoreData

class ReadXMinutesGoalModel:GoalModel{
    var totalMinutes:Int!
    var goalType:GoalType!
    var minutesRead:Int!
    
    init(name:String,date:Date, goalType:GoalType,totalMinutes:Int){
        self.goalType = goalType
        self.totalMinutes = totalMinutes
        minutesRead = 0
        super.init(name: name,date:date)
    }
    
    init(name:String,progress:Int,date:Date,goalType:GoalType, totalMinutes:Int, minutesRead:Int){
        self.goalType = goalType
        self.totalMinutes = totalMinutes
        self.minutesRead = minutesRead
        super.init(name: name, progress: progress,date:date)
    }
    
    init(model:ReadXMinutesCD){
        super.init(name: model.name!, progress: Int(model.progress), date: model.date! as Date)
        self.totalMinutes = Int(model.totalMinutes)
        self.minutesRead = Int(model.minutesRead)
        self.goalType = GoalType(rawValue: model.goalType!)
    }
    
    func find(name:String,date:Date,returnOnlySameDate:Bool)->ReadXMinutesCD?{
        let model:ReadXMinutesCD? = CoreDataGetter.shared.find(name: name, date: date, goalType: goalType, returnOnlySameDate: returnOnlySameDate)
        
        return model
    }
    
    override func getDescriptionWithProgress() -> String {
        return  "\(name): \(totalMinutes - minutesRead) minute(s) left"
    }
}
