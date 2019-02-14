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
    var articles:[ArticleModel] = [ArticleModel]()
    
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
            let articlesUrls = model.articles as! [String]
            
            self.articles = ArticleManager.shared.getArticles(from: articlesUrls)
        }
        self.goalType = GoalType(rawValue: model.goalType!)
        self.numberOfArticles = Int(model.numberOfArticles)
        self.showCompletionToUser = model.showCompletionToUser
    }
    
    
    
    func find(name:String,date:Date)->ReadXArticlesCD?{
        let model:ReadXArticlesCD? = CoreDataGetter.shared.find(name: name, date: date, goalType: goalType)
        
        return model
    }
    
    override func getDescriptionWithProgress() -> String {
        return  "\(name): \(articles.count)/\(Int(numberOfArticles))"
    }
}
