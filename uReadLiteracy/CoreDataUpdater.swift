//
//  CoreManagerSaver.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/13/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataUpdater{
    static let shared = CoreDataUpdater()
    
    private var appDelegate:AppDelegate!
    private let managedContext:NSManagedObjectContext
    
    init(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        managedContext.automaticallyMergesChangesFromParent = true
    }
    
    func save(audioRecordModel:AudioRecordModel){
        let model:AudioRecordCD? = nil
        
        if(model == nil){
            let entity = NSEntityDescription.entity(forEntityName: "AudioRecordCD", in: managedContext)!
            let object = NSManagedObject(entity: entity, insertInto: managedContext)
            
            object.setValue(audioRecordModel.path, forKeyPath: "path")
            object.setValue(audioRecordModel.title, forKeyPath: "title")
            object.setValue(audioRecordModel.date, forKeyPath: "date")
        }
        else{
            model?.path = audioRecordModel.path
            model?.title = audioRecordModel.title
            model?.date = audioRecordModel.date as! NSDate
        }
        
        save()
    }
    
    func save(helpModel:HelpWordModel){
        if(helpModel.timesAsked < 0){
            helpModel.timesAsked = 0
        }
        
        let model:HelpWordCD? = CoreDataGetter.shared.find(helpWord: helpModel.word)
        if(model == nil){
            let wordEntity = NSEntityDescription.entity(forEntityName: "HelpWordCD", in: managedContext)!
            
            let wordObject = NSManagedObject(entity: wordEntity, insertInto: managedContext)
    
            wordObject.setValue(helpModel.word, forKeyPath: "word")
            wordObject.setValue(helpModel.timesAsked, forKeyPath: "timesAsked")
            wordObject.setValue(helpModel.askedLastArticle, forKey: "askedLastArticle")
        }
        else{
            model?.timesAsked = Int16(helpModel.timesAsked)
            model?.askedLastArticle = helpModel.askedLastArticle
        }
        
        save()
    }
    
    func save(goalModel:ReadXArticlesGoalModel){
        if goalModel.articles.count == goalModel.numberOfArticles {
            goalModel.progress = 100
        }
        
        
        var modelSameDate:ReadXArticlesCD? = CoreDataGetter.shared.find(name: goalModel.name, date: goalModel.date, goalType: goalModel.goalType, returnOnlySameDate: true)
        var modelDifferentDate:ReadXArticlesCD? = CoreDataGetter.shared.find(name: goalModel.name, date: goalModel.date, goalType: goalModel.goalType, returnOnlySameDate: false)
        
        if(modelSameDate == nil && modelDifferentDate == nil ){
            let entity = NSEntityDescription.entity(forEntityName: "ReadXArticlesCD", in: managedContext)!
            let object = NSManagedObject(entity: entity, insertInto: managedContext)
            object.setValue(goalModel.name, forKeyPath: "name")
            object.setValue(goalModel.progress, forKeyPath: "progress")
            object.setValue(goalModel.goalType.rawValue, forKeyPath: "goalType")
            object.setValue(goalModel.date, forKeyPath: "date")
            object.setValue(goalModel.numberOfArticles, forKeyPath: "numberOfArticles")
        }
        else{
            modelSameDate?.progress = Int16(goalModel.progress)
            modelDifferentDate?.progress = Int16(goalModel.progress)
        }
        
        save()
    }
    
    func save(goalModel:ReadXMinutesGoalModel){
        let modelSameDate:ReadXMinutesCD? = CoreDataGetter.shared.find(name: goalModel.name, date: goalModel.date, goalType:goalModel.goalType, returnOnlySameDate: true)
        let modelDifferentDate:ReadXMinutesCD? = CoreDataGetter.shared.find(name: goalModel.name, date: goalModel.date, goalType:goalModel.goalType, returnOnlySameDate: false)
        
        let entity = NSEntityDescription.entity(forEntityName: "ReadXMinutesCD", in: managedContext)!
        
        if goalModel.totalMinutes == goalModel.minutesRead{
            goalModel.progress = 100
        }
        
        if(modelSameDate == nil && modelDifferentDate == nil){
            let object = NSManagedObject(entity: entity, insertInto: managedContext)
            object.setValue(goalModel.name, forKeyPath: "name")
            object.setValue(goalModel.progress, forKeyPath: "progress")
            object.setValue(goalModel.goalType.rawValue, forKeyPath: "goalType")
            object.setValue(goalModel.date, forKeyPath: "date")
            object.setValue(goalModel.totalMinutes, forKeyPath: "totalMinutes")
            object.setValue(goalModel.minutesRead, forKeyPath: "minutesRead")
        }
        else{
            modelSameDate?.minutesRead = Int16(goalModel.minutesRead)
            modelDifferentDate?.minutesRead = Int16(goalModel.minutesRead)
            
            var progress = Int(Float(goalModel.minutesRead/goalModel.totalMinutes)*100)
            if goalModel.totalMinutes == goalModel.minutesRead{
                goalModel.progress = 100
            }
            
            modelSameDate?.progress = Int16(goalModel.progress)
            modelDifferentDate?.progress = Int16(goalModel.progress)
        }
        
        save()
    }
    
    func save(goalModel:GoalModel){
        if let goalModel = goalModel as? ReadXMinutesGoalModel{
            save(goalModel: goalModel)
        }
        if let goalModel = goalModel as? ReadXArticlesGoalModel{
            save(goalModel: goalModel)
        }
    }
    
    func save(model:CurrentUser){
        let userEntity = NSEntityDescription.entity(forEntityName: "UserCD", in: managedContext)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        user.setValue(model.nickname, forKeyPath: "nickname")
        user.setValue(model.uid, forKeyPath: "uid")
        user.setValue(model.email, forKeyPath: "email")
        user.setValue(model.password, forKeyPath: "password")
        
        if model.image != nil {
            let data = UIImagePNGRepresentation(model.image!)
            user.setValue(data, forKeyPath: "image")
        }
        
        save()
    }
    
    func delete(helpModel:HelpWordModel){
        let model:HelpWordCD? = CoreDataGetter.shared.find(helpWord: helpModel.word)
        if(model != nil){
            managedContext.delete(model!)
        }
        save()
    }
    
    func delete(goal:GoalModel, goalType:GoalType){
        let readXMinute:ReadXMinutesCD? = CoreDataGetter.shared.find(name: goal.name, date: goal.date, goalType: goalType, returnOnlySameDate: false)
        let readXArticle:ReadXArticlesCD? = CoreDataGetter.shared.find(name: goal.name, date: goal.date, goalType: goalType, returnOnlySameDate: false)
        if(readXMinute != nil){
            managedContext.delete(readXMinute!)
            save()
        }
        else if(readXArticle != nil){
            managedContext.delete(readXArticle!)
            save()
        }
    }
    
    private func save(){
        do {
            try managedContext.save()
            appDelegate.saveContext()
        } catch let error as NSError {
            fatalError("Could not save. \(error), \(error.userInfo)")
        }
    }
}
