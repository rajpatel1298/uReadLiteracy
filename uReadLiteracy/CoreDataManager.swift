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

class CoreDataManager{
    static let shared = CoreDataManager()
    
    private var appDelegate:AppDelegate!
    private let managedContext:NSManagedObjectContext
    
    init(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
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
    
    func getList() -> [ReadXArticlesCD] {
        let goalFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ReadXArticlesCD")
        
        let goals = try! managedContext.fetch(goalFetch) as! [ReadXArticlesCD]
        return goals
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
    
    func getList()->[ReadXMinutesCD]{
        let goalFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ReadXMinutesCD")
        
        let goals = try! managedContext.fetch(goalFetch) as! [ReadXMinutesCD]
        return goals
    }
    
    func getList()->[HelpWordModel]{
        let wordFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "HelpWordCD")
        let words = try! managedContext.fetch(wordFetch) as! [HelpWordCD]
        
        var list = [HelpWordModel]()
        
        for word in words{
            let w = HelpWordModel(word: word.word!, beginningDifficult: word.beginningDifficult, endingDifficult: word.endingDifficult, blendDifficult: word.blendDifficult, multisyllabicDifficult: word.multisyllabicDifficult)
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
    
    func getList() -> [ArticleCD] {
        let articleFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleCD")
        
        let articles = try! managedContext.fetch(articleFetch) as! [ArticleCD]
        
        return articles
    }
}
