//
//  DailyGoalModel.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/24/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import CoreData

class DailyGoalModel:GoalModel{
    var articles = [ArticleModel]()
    var type:DailyGoalType!
    
    init(name:String,date:Date,type:DailyGoalType){
        self.type = type
        super.init(name: name,date:date)
    }
    
    init(name:String,progress:Double,articles:[ArticleModel],date:Date,type:DailyGoalType){
        super.init(name: name, progress: progress,date:date)
        self.type = type
        self.articles = articles
    }
    
    init(model:DailyGoal){
        super.init(name: model.name!, progress: model.progress, date: model.date! as Date)
        if(model.articlesUrls != nil){
            self.articles = ArticleModel.getArticles(from: model.articlesUrls!)
        }
        
        self.type = DailyGoalType(rawValue: model.type!)
    }
    
    func save(){
        let managedContext = CoreDataHelper.sharedInstance.getManagedContext()
        
        let model:DailyGoal? = DailyGoalModel.find(name: name, date: date)
        
        if(model == nil){
            let entity = NSEntityDescription.entity(forEntityName: "DailyGoal", in: managedContext)!
            let object = NSManagedObject(entity: entity, insertInto: managedContext)
            
            object.setValue(name, forKeyPath: "name")
            object.setValue(date, forKeyPath: "date")
            object.setValue(ArticleModel.getUrls(articles: articles), forKeyPath: "articlesUrls")
            object.setValue(name, forKeyPath: "name")
            object.setValue(type.rawValue, forKeyPath: "type")
    
        }
        else{
            model?.name = name
            model?.date = date as NSDate
            model?.articlesUrls = ArticleModel.getUrls(articles: articles)
            model?.progress = progress
            model?.type = type.rawValue
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func find(name:String,date:Date)->DailyGoal?{
        let managedContext = CoreDataHelper.sharedInstance.getManagedContext()
        let goalFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "DailyGoal")
        
        let goals = try! managedContext.fetch(goalFetch) as! [DailyGoal]
        
        for goal in goals{
            if(goal.name == name && (goal.date! as Date) == date){
                return goal
            }
        }
        
        return nil
    }
    
    static func getModels()->[DailyGoalModel]{
        let managedContext = CoreDataHelper.sharedInstance.getManagedContext()
        let goalFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "DailyGoal")
        
        let goals = try! managedContext.fetch(goalFetch) as! [DailyGoal]
        
        var arr = [DailyGoalModel]()
        
        for goal in goals{
            let model = DailyGoalModel(name: goal.name!, progress: goal.progress, articles: ArticleModel.getArticles(from: goal.articlesUrls!),date:goal.date! as Date,type:DailyGoalType(rawValue: goal.type!)!)
            arr.append(model)
        }
        
        return arr
    }
    
    static func updateGoals(articleUpdate:ArticleModel){
        let managedContext = CoreDataHelper.sharedInstance.getManagedContext()
        let goalFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "DailyGoal")
        
        let goals = try! managedContext.fetch(goalFetch)
        
        if let goals = goals as? ([DailyGoal]){
            for goal in goals{
                let goal = DailyGoalModel(model: goal)
                
                var articleExist = false
                for item in goal.articles{
                    if(item.equal(article: articleUpdate)){
                        articleExist = true
                        break
                    }
                }
                
                if(!articleExist){
                    goal.articles.append(articleUpdate)
                    goal.progress = goal.progress + 1
                    goal.save()
                }
                
            }
        }
        
        
    }
}
