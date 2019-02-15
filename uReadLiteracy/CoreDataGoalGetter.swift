//
//  CoreDataGoalGetter.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/14/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataGoalGetter{
    private var appDelegate:AppDelegate!
    private let managedContext:NSManagedObjectContext
    
    init(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func find(name:String,date:Date, goalType:GoalType)->ReadXMinutesCD?{
        let goals:[ReadXMinutesCD] = CoreDataGetter.shared.getList()
        
        for goal in goals{
            if goal.name == name{
                if goalType == .Daily{
                    let components = Calendar.current.dateComponents([.year,.month,.day], from: goal.date! as Date, to: Date())
                    
                    if(components.year == 0 && components.month == 0 && components.day == 0){
                        return goal
                    }
                }
                else{
                    return goal
                }
            }
        }
        
        return nil
    }
    
    func find(name:String,date:Date, goalType:GoalType)->ReadXArticlesCD?{
        let goals:[ReadXArticlesCD] = getList()
        
        for goal in goals{
            if goal.name == name{
                if goalType == .Daily{
                    let components = Calendar.current.dateComponents([.year,.month,.day], from: goal.date! as Date, to: Date())
                    
                    if(components.year == 0 && components.month == 0 && components.day == 0){
                        return goal
                    }
                }
                else{
                    return goal
                }
            }
        }
        
        return nil
    }
    
    func getList() -> [ReadXArticlesCD] {
        let goalFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ReadXArticlesCD")
        
        let goals = try! managedContext.fetch(goalFetch) as! [ReadXArticlesCD]
        return goals
    }
    
    func getList()->[ReadXMinutesCD]{
        let goalFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ReadXMinutesCD")
        
        let goals = try! managedContext.fetch(goalFetch) as! [ReadXMinutesCD]
        return goals
    }
    
    func getList() -> [ReadXArticlesGoalModel] {
        let goals:[ReadXArticlesCD] = getList()
        
        var arr = [ReadXArticlesGoalModel]()
        
        for goal in goals{
            let model = ReadXArticlesGoalModel(model: goal)
            arr.append(model)
        }
        return arr
    }
    
    func getList() -> [ReadXMinutesGoalModel] {
        let goals : [ReadXMinutesCD] = getList()
        
        var arr = [ReadXMinutesGoalModel]()
        
        for goal in goals{
            let model = ReadXMinutesGoalModel(model: goal)
            arr.append(model)
        }
        return arr
    }
}
