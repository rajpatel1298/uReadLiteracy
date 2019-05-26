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
    
    func saveArticle(url:String,minutesRead:Int,category:ArticleCategory){
        let model = CoreDataGetter.shared.find(articleUrlToFind: url)
        if(model != nil){
            model?.minutesRead = Int16(minutesRead)
        }
        else{
            let entity = NSEntityDescription.entity(forEntityName: "ArticleCD", in: managedContext)!
            let object = NSManagedObject(entity: entity, insertInto: managedContext)
            
            object.setValue(url, forKeyPath: "url")
            object.setValue(minutesRead, forKeyPath: "minutesRead")
            object.setValue(category.rawValue, forKeyPath: "category")
        }
        save()
    }
    
    func save(article:ArticleModel){
        saveArticle(url: article.url, minutesRead: Int(article.minutesRead), category: article.category)
    }
    
    func delete(helpModel:HelpWordModel){
        let model:HelpWordCD? = CoreDataGetter.shared.find(helpWord: helpModel.word)
        if(model != nil){
            managedContext.delete(model!)
        }
        save()
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
