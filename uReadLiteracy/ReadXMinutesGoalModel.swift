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
    var minutes:Int!
    var goalType:GoalType!
    
    init(name:String,date:Date, goalType:GoalType,minutes:Int){
        self.goalType = goalType
        self.minutes = minutes
        super.init(name: name,date:date)
    }
    
    init(name:String,progress:Int,date:Date,goalType:GoalType, minutes:Int){
        self.goalType = goalType
        self.minutes = minutes
        super.init(name: name, progress: progress,date:date)
    }
    
    init(model:ReadXMinutes){
        super.init(name: model.name!, progress: Int(model.progress), date: model.date! as Date)
        self.minutes = Int(model.minutes)
        self.goalType = GoalType(rawValue: model.goalType!)
    }
    
    override func save(){
        let managedContext = CoreDataHelper.sharedInstance.getManagedContext()
        
        let model = find(name: name, date: date)
        
        let entity = NSEntityDescription.entity(forEntityName: "ReadXMinutes", in: managedContext)!
        
        if(model == nil){
            let object = NSManagedObject(entity: entity, insertInto: managedContext)
            object.setValue(name, forKeyPath: "name")
            object.setValue(progress, forKeyPath: "progress")
            object.setValue(goalType.rawValue, forKeyPath: "goalType")
            object.setValue(date, forKeyPath: "date")
            object.setValue(minutes, forKeyPath: "minutes")
        }
        else{
            model?.minutes = self.minutes
            model?.progress = self.progress
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func find(name:String,date:Date)->ReadXMinutesGoalModel?{
        let model:ReadXMinutesGoalModel? = ReadXMinutesGoalModel.find(name: name, date: date, goalType: goalType)
        
        return model
    }
    
    static func find(name:String,date:Date, goalType:GoalType)->ReadXMinutesGoalModel?{
        let goals = ReadXMinutesGoalModel.getModels()
        
        for goal in goals{
            if(goal.name == name && goal.date == date){
                return goal
            }
        }
        
        return nil
    }
    
    
    static func getModels()->[ReadXMinutesGoalModel]{
        let managedContext = CoreDataHelper.sharedInstance.getManagedContext()
        let goalFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ReadXMinutes")
        
        let goals = try! managedContext.fetch(goalFetch) as! [ReadXMinutes]
        
        var arr = [ReadXMinutesGoalModel]()
        
        for goal in goals{
            let model = ReadXMinutesGoalModel(model: goal)
            arr.append(model)
        }
         return arr
    }
    
    func updateGoals(){
        fatalError("Not implemented")
        
    }
}
