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
            if progress == 99 {
                progress = 100
            }
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
    
    init(model:ReadXArticlesCD){
        super.init(name: model.name!, progress: Int(model.progress), date: model.date! as Date)
        if(model.articles != nil){
            let articlesUrl = model.articles as! [String]
            self.articles = ArticleModel.getArticles(from: articlesUrl)
        }
        self.goalType = GoalType(rawValue: model.goalType!)
        self.numberOfArticles = Int(model.numberOfArticles)
        self.showCompletionToUser = model.showCompletionToUser
    }
    
    override func save(){
        if progress == 99 {
            progress = 100
        }
        
        let model = find(name: name, date: date)
    
        let entity = NSEntityDescription.entity(forEntityName: "ReadXArticlesCD", in: managedContext)!

        if(model == nil){
            let object = NSManagedObject(entity: entity, insertInto: managedContext)
            object.setValue(name, forKeyPath: "name")
            object.setValue(progress, forKeyPath: "progress")
            object.setValue(goalType.rawValue, forKeyPath: "goalType")
            object.setValue(date, forKeyPath: "date")
            object.setValue(numberOfArticles, forKeyPath: "numberOfArticles")
            object.setValue(ArticleModel.getUrls(articles: articles), forKeyPath: "articles")
            object.setValue(showCompletionToUser, forKeyPath: "showCompletionToUser")
        }
        else{
            model?.articles = ArticleModel.getUrls(articles: self.articles) as NSObject
            model?.progress = Int16(self.progress)
            model?.showCompletionToUser = self.showCompletionToUser
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func find(name:String,date:Date)->ReadXArticlesCD?{
        let model = ReadXArticlesGoalModel.find(name: name, date: date, goalType: goalType)
        
        return model
    }
    
    static func find(name:String,date:Date, goalType:GoalType)->ReadXArticlesCD?{
   
        let goals:[ReadXArticlesCD] = CoreDataManager.shared.getList()
        
        for goal in goals{
            
            let components = Calendar.current.dateComponents([.year,.month,.day], from: goal.date! as Date, to: Date())
            
            
            if(goal.name == name && components.year == 0 && components.month == 0 && components.day == 0){
                return goal
            }
        }
        
        return nil
    }
    
    
    
    override func getDescriptionWithProgress() -> String {
        return  "\(name): \(articles.count)/\(Int(numberOfArticles))"
    }
}
