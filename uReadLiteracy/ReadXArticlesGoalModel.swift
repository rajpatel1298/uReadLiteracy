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
    
    
    var articles:[ArticleModel] = [ArticleModel](){
        didSet{
            progress = Int(Float(articles.count/numberOfArticles)*100)
        }
    }
    
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
            model?.articles = ArticleModel.getUrls(articles: self.articles) as NSObject
            model?.progress = Int16(self.progress)
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func find(name:String,date:Date)->ReadXArticles?{
        let model = ReadXArticlesGoalModel.find(name: name, date: date, goalType: goalType)
        
        return model
    }
    
    static func find(name:String,date:Date, goalType:GoalType)->ReadXArticles?{
        let goals:[ReadXArticles] = ReadXArticlesGoalModel.getModels()
        
        for goal in goals{
            
            let components = Calendar.current.dateComponents([.year,.month,.day], from: goal.date! as Date, to: Date())
            
            
            if(goal.name == name && components.year == 0 && components.month == 0 && components.day == 0){
                return goal
            }
        }
        
        return nil
    }
    
    
    static func getModels()->[ReadXArticlesGoalModel]{
        let goals:[ReadXArticles] = ReadXArticlesGoalModel.getModels()
        
        var arr = [ReadXArticlesGoalModel]()
        
        for goal in goals{
            let model = ReadXArticlesGoalModel(model: goal)
            arr.append(model)
        }
        return arr
    }
    
    static func getModels()->[ReadXArticles]{
        let managedContext = CoreDataHelper.sharedInstance.getManagedContext()
        let goalFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ReadXArticles")
        
        let goals = try! managedContext.fetch(goalFetch) as! [ReadXArticles]
        return goals
    }
    
    override func getDescriptionWithProgress() -> String {
        return  "\(name): \(articles.count)/\(Int(numberOfArticles))"
    }
}
