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

class CoreDataSaver{
    static let shared = CoreDataSaver()
    
    private var appDelegate:AppDelegate!
    private let managedContext:NSManagedObjectContext
    
    init(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func save(goalModel:ReadXArticlesGoalModel){
        if goalModel.articles.count == goalModel.numberOfArticles {
            goalModel.progress = 100
        }
        
        
        let model:ReadXArticlesCD? = CoreDataGetter.shared.find(name: goalModel.name, date: goalModel.date, goalType: goalModel.goalType)
        
        let entity = NSEntityDescription.entity(forEntityName: "ReadXArticlesCD", in: managedContext)!
        
        if(model == nil){
            let object = NSManagedObject(entity: entity, insertInto: managedContext)
            object.setValue(goalModel.name, forKeyPath: "name")
            object.setValue(goalModel.progress, forKeyPath: "progress")
            object.setValue(goalModel.goalType.rawValue, forKeyPath: "goalType")
            object.setValue(goalModel.date, forKeyPath: "date")
            object.setValue(goalModel.numberOfArticles, forKeyPath: "numberOfArticles")
            
            let articles = ArticleManager.shared.getUrls(articles: goalModel.articles)
            
            object.setValue(articles, forKeyPath: "articles")
            object.setValue(goalModel.showCompletionToUser, forKeyPath: "showCompletionToUser")
        }
        else{
            model?.articles = ArticleManager.shared.getUrls(articles: goalModel.articles) as NSObject
            model?.progress = Int16(goalModel.progress)
            model?.showCompletionToUser = goalModel.showCompletionToUser
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func save(articleModel:ArticleModel){
        let model:ArticleCD? = CoreDataGetter.shared.find(url: articleModel.url)
        
        if(model == nil){
            let articleEntity = NSEntityDescription.entity(forEntityName: "ArticleCD", in: managedContext)!
            let articleObject = NSManagedObject(entity: articleEntity, insertInto: managedContext)
            
            articleObject.setValue(articleModel.name, forKeyPath: "name")
            articleObject.setValue(articleModel.readCount, forKeyPath: "readCount")
            articleObject.setValue(articleModel.url, forKeyPath: "url")
        }
        else{
            model?.name = articleModel.name
            model?.readCount = articleModel.readCount
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
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
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func save(helpModel:HelpWordModel){
        let wordEntity = NSEntityDescription.entity(forEntityName: "HelpWordCD", in: managedContext)!
        
        let wordObject = NSManagedObject(entity: wordEntity, insertInto: managedContext)
        
        helpModel.getWordDifficultyIfNil()
        
        wordObject.setValue(helpModel.word, forKeyPath: "word")
        wordObject.setValue(helpModel.beginningDifficult, forKeyPath: "beginningDifficult")
        wordObject.setValue(helpModel.endingDifficult, forKeyPath: "endingDifficult")
        wordObject.setValue(helpModel.blendDifficult, forKeyPath: "blendDifficult")
        wordObject.setValue(helpModel.multisyllabicDifficult, forKeyPath: "multisyllabicDifficult")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func save(goalModel:ReadXMinutesGoalModel){
        let model:ReadXMinutesCD? = CoreDataGetter.shared.find(name: goalModel.name, date: goalModel.date, goalType:goalModel.goalType)
        
        let entity = NSEntityDescription.entity(forEntityName: "ReadXMinutesCD", in: managedContext)!
        
        if goalModel.totalMinutes == goalModel.minutesRead{
            goalModel.progress = 100
        }
        
        if(model == nil){
            let object = NSManagedObject(entity: entity, insertInto: managedContext)
            object.setValue(goalModel.name, forKeyPath: "name")
            object.setValue(goalModel.progress, forKeyPath: "progress")
            object.setValue(goalModel.goalType.rawValue, forKeyPath: "goalType")
            object.setValue(goalModel.date, forKeyPath: "date")
            object.setValue(goalModel.totalMinutes, forKeyPath: "totalMinutes")
            object.setValue(goalModel.minutesRead, forKeyPath: "minutesRead")
            object.setValue(goalModel.showCompletionToUser, forKeyPath: "showCompletionToUser")
        }
        else{
            model?.minutesRead = Int16(goalModel.minutesRead)
            
            var progress = Int(Float(goalModel.minutesRead/goalModel.totalMinutes)*100)
            if goalModel.totalMinutes == goalModel.minutesRead{
                goalModel.progress = 100
            }
            
            model?.progress = Int16(goalModel.progress)
            model?.showCompletionToUser = goalModel.showCompletionToUser
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func save(goalModel:GoalModel){
        if let goalModel = goalModel as? ReadXMinutesGoalModel{
            save(goalModel: goalModel)
        }
        if let goalModel = goalModel as? ReadXArticlesGoalModel{
            save(goalModel: goalModel)
        }
    }
    
    func save(model:MainUserModel){
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
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            fatalError("Could not save. \(error), \(error.userInfo)")
        }
    }
}
