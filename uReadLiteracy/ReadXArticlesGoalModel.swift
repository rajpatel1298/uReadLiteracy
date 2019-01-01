//
//  ReadXArticlesGoal.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 12/29/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import CoreData

class ReadXArticlesGoalModel:GoalModel{
    
    
    var articles = [ArticleModel]()
    var numberOfArticles:Int!
    var goalType:GoalType!
    
    init(name:String,date:Date, goalType:GoalType,numberOfArticles:Int){
        self.goalType = goalType
        self.numberOfArticles = numberOfArticles
        super.init(name: name,date:date)
    }
    
    init(name:String,progress:Int,articles:[ArticleModel],date:Date,goalType:GoalType, numberOfArticles:Int){
        self.goalType = goalType
        self.articles = articles
        self.numberOfArticles = numberOfArticles
        super.init(name: name, progress: progress,date:date)
    }
    

    
    init(model:ReadXArticles){
        super.init(name: model.name!, progress: Int(model.progress), date: model.date! as Date)
        if(model.articles != nil){
            let articlesUrl = model.articles as! [String]
            self.articles = ArticleModel.getArticles(from: articlesUrl)
        }
        self.goalType = GoalType(rawValue: model.goalType!)
        self.numberOfArticles = Int(model.numberOfArticles)
    }
    
    override func save(){
        let managedContext = CoreDataHelper.sharedInstance.getManagedContext()
        
        let model = find(name: name, date: date)
        
        
        let entity = NSEntityDescription.entity(forEntityName: "ReadXArticles", in: managedContext)!

        if(model == nil){
            let object = NSManagedObject(entity: entity, insertInto: managedContext)
            object.setValue(name, forKeyPath: "name")
            object.setValue(progress, forKeyPath: "progress")
            object.setValue(goalType.rawValue, forKeyPath: "goalType")
            object.setValue(date, forKeyPath: "date")
            object.setValue(numberOfArticles, forKeyPath: "numberOfArticles")
            object.setValue(ArticleModel.getUrls(articles: articles), forKeyPath: "articles")
        }
        else{
            model?.articles = self.articles
            model?.progress = self.progress
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func find(name:String,date:Date)->ReadXArticlesGoalModel?{
        let model:ReadXArticlesGoalModel? = ReadXArticlesGoalModel.find(name: name, date: date, goalType: goalType)
        
        return model
    }
    
    static func find(name:String,date:Date, goalType:GoalType)->ReadXArticlesGoalModel?{
        let goals = ReadXArticlesGoalModel.getModels()
        
        for goal in goals{
            let components = Calendar.current.dateComponents([.year,.month,.day], from: goal.date, to: Date())
            
            
            if(goal.name == name && components.year == 0 && components.month == 0 && components.day == 0){
                return goal
            }
        }
        
        return nil
    }
    
    
    static func getModels()->[ReadXArticlesGoalModel]{
        let managedContext = CoreDataHelper.sharedInstance.getManagedContext()
        let goalFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ReadXArticles")
        
        let goals = try! managedContext.fetch(goalFetch) as! [ReadXArticles]
        
        var arr = [ReadXArticlesGoalModel]()
        
        for goal in goals{
            let model = ReadXArticlesGoalModel(model: goal)
            arr.append(model)
        }
        return arr
    }
    
    static func updateGoals(articleUpdate:ArticleModel){
        let goals = ReadXArticlesGoalModel.getModels()
        
        for goal in goals{
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
    
    override func getDescriptionWithProgress() -> String {
        return  "\(name): \(articles.count)/\(Int(numberOfArticles))"
    }
}
