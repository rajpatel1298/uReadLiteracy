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
    
    init(model:ReadXMinutes){
        super.init(name: model.name!, progress: Int(model.progress), date: model.date! as Date)
        self.totalMinutes = Int(model.totalMinutes)
        self.minutesRead = Int(model.minutesRead)
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
            object.setValue(totalMinutes, forKeyPath: "totalMinutes")
            object.setValue(minutesRead, forKeyPath: "minutesRead")
        }
        else{
            model?.minutesRead = Int16(self.minutesRead)
            model?.progress = Int16(Float(self.minutesRead/self.totalMinutes)*100)
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func find(name:String,date:Date)->ReadXMinutes?{
        let model = ReadXMinutesGoalModel.find(name: name, date: date, goalType: goalType)
        
        return model
    }
    
    static func find(name:String,date:Date, goalType:GoalType)->ReadXMinutes?{
        let goals:[ReadXMinutes] = ReadXMinutesGoalModel.getModels()
        
        for goal in goals{
            let components = Calendar.current.dateComponents([.year,.month,.day], from: goal.date! as Date, to: Date())
            
            
            if(goal.name == name && components.year == 0 && components.month == 0 && components.day == 0){
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
    
    static func getModels()->[ReadXMinutes]{
        let managedContext = CoreDataHelper.sharedInstance.getManagedContext()
        let goalFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ReadXMinutes")
        
        let goals = try! managedContext.fetch(goalFetch) as! [ReadXMinutes]
        return goals
    }
    
    override func getDescriptionWithProgress() -> String {
        return  "\(name): \(totalMinutes - minutesRead) minute(s) left"
    }
}
