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
        self.showCompletionToUser = showCompletionToUser
    }
    
    override func save(){
        let model = find(name: name, date: date)
        
        let entity = NSEntityDescription.entity(forEntityName: "ReadXMinutesCD", in: managedContext)!
        
        if progress == 99{
            progress = 100
        }
        
        if(model == nil){
            let object = NSManagedObject(entity: entity, insertInto: managedContext)
            object.setValue(name, forKeyPath: "name")
            object.setValue(progress, forKeyPath: "progress")
            object.setValue(goalType.rawValue, forKeyPath: "goalType")
            object.setValue(date, forKeyPath: "date")
            object.setValue(totalMinutes, forKeyPath: "totalMinutes")
            object.setValue(minutesRead, forKeyPath: "minutesRead")
            object.setValue(showCompletionToUser, forKeyPath: "showCompletionToUser")
        }
        else{
            model?.minutesRead = Int16(self.minutesRead)
            
            var progress = Int(Float(self.minutesRead/self.totalMinutes)*100)
            if progress == 99{
                progress = 100
            }

            model?.progress = Int16(progress)
            model?.showCompletionToUser = showCompletionToUser
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func find(name:String,date:Date)->ReadXMinutesCD?{
        let model = ReadXMinutesGoalModel.find(name: name, date: date, goalType: goalType)
        
        return model
    }
    
    static func find(name:String,date:Date, goalType:GoalType)->ReadXMinutesCD?{
        let goals:[ReadXMinutesCD] = ReadXMinutesGoalModel.getCDModels()
        
        for goal in goals{
            let components = Calendar.current.dateComponents([.year,.month,.day], from: goal.date! as Date, to: Date())
            
            
            if(goal.name == name && components.year == 0 && components.month == 0 && components.day == 0){
                return goal
            }
        }
        
        return nil
    }
    
    
    override func getList() -> [Any] {
        let goalFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ReadXMinutesCD")
        
        let goals = try! managedContext.fetch(goalFetch) as! [ReadXMinutesCD]
        
        var arr = [ReadXMinutesGoalModel]()
        
        for goal in goals{
            let model = ReadXMinutesGoalModel(model: goal)
            arr.append(model)
        }
        return arr
    }
    
    private static func getCDModels()->[ReadXMinutesCD]{
        let goalFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ReadXMinutesCD")
        
        let goals = try! shared.managedContext.fetch(goalFetch) as! [ReadXMinutesCD]
        return goals
    }
    
    override func getDescriptionWithProgress() -> String {
        return  "\(name): \(totalMinutes - minutesRead) minute(s) left"
    }
}
