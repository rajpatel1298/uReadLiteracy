//
//  CoreDataHelper.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/8/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataGetter{
    static let shared = CoreDataGetter()
    
    private var appDelegate:AppDelegate!
    private let managedContext:NSManagedObjectContext
        
    init(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func getList()->[HelpWordModel]{
        let wordFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "HelpWordCD")
        let words = try! managedContext.fetch(wordFetch) as! [HelpWordCD]
        
        var list = [HelpWordModel]()
        
        for word in words{
            let w = HelpWordModel(word: word.word!, beginningDifficult: word.beginningDifficult, endingDifficult: word.endingDifficult, blendDifficult: word.blendDifficult, multisyllabicDifficult: word.multisyllabicDifficult, timesAsked:Int(word.timesAsked))
            list.append(w)
        }
        
        return list
    }
    
    func getList() -> [AudioRecordCD] {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "AudioRecordCD")
        
        let list = try! managedContext.fetch(fetch) as! [AudioRecordCD]
        return list
    }
    
    func getList() -> [AudioRecordModel] {
        let list:[AudioRecordCD] = getList()
        
        var models = [AudioRecordModel]()
        for item in list{
            let model = AudioRecordModel(path: item.path!, title: item.title!, date: (item.date! as Date))
            models.append(model)
        }
        
        return models
    }
    
    
    func find(path:String,title:String,date:Date)->AudioRecordCD?{
        let list:[AudioRecordCD] = getList()
        
        for item in list{
            if(item.path == path && item.title == title && (item.date! as Date) == date){
                return item
            }
        }
        
        return nil
    }
    
    
    
    func getMainUser()->UserCD?{
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserCD")
        let users = try! managedContext.fetch(userFetch)
        
        if(users.count > 0){
            return users.first as! UserCD
        }
        return nil
    }
    
    
    
    // Goals
    
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
    
    func find(helpWord:String)->HelpWordCD?{
        let words:[HelpWordCD] = getList()
        for word in words{
            if word.word == helpWord{
                return word
            }
        }
        return nil
    }
    
    func getList() -> [ReadXArticlesCD] {
        managedContext.refreshAllObjects()
        let goalFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ReadXArticlesCD")
        goalFetch.shouldRefreshRefetchedObjects = true
        
        let goals = try! managedContext.fetch(goalFetch) as! [ReadXArticlesCD]
        return goals
    }
    
    func getList() -> [HelpWordCD] {
        managedContext.refreshAllObjects()
        let wordFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "HelpWordCD")
        wordFetch.shouldRefreshRefetchedObjects = true
        
        let words = try! managedContext.fetch(wordFetch) as! [HelpWordCD]
        return words
    }
    
    func getList()->[ReadXMinutesCD]{
        managedContext.refreshAllObjects()
        let goalFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ReadXMinutesCD")
        goalFetch.shouldRefreshRefetchedObjects = true
      
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
