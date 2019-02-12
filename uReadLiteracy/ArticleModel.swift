//
//  ArticleModel.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/23/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import CoreData

class ArticleModel:CoreDataModelHandler{
    private var name:String
    private var readCount:Double
    
    // 1 unit = 1 second
    var totalTimeSpent:Double
    
    let url:String

  
    init(name:String,readCount:Double,timeSpent:Double,url:String){
        
        self.name = name
        self.readCount = readCount
        self.totalTimeSpent = timeSpent
        self.url = url
        super.init()
        
        fixNameParsing()
    }
    
    init(name:String,url:String){
        self.name = name
        self.url = url
        
        let model:ArticleModel? = ArticleManager.shared.find(url: url)
        
        if(model == nil){
            self.readCount = 0
            self.totalTimeSpent = 0
        }
        else{
            self.readCount = (model?.readCount)!
            self.totalTimeSpent = (model?.totalTimeSpent)!
        }
        
        super.init()
        
        fixNameParsing()
    }
    
    func getTitle()->String{
        return name
    }
    
    private func fixNameParsing(){
        name = name.replacingOccurrences(of: "Text & MP3 File", with: "")
    }
    
    func incrementReadCount(){
        readCount = readCount + 1
        save()
    }
    
    internal override func save(){
        let model:ArticleCD? = findCoreDataModel(url: url)
        
        if(model == nil){
            let articleEntity = NSEntityDescription.entity(forEntityName: "ArticleCD", in: managedContext)!
            let articleObject = NSManagedObject(entity: articleEntity, insertInto: managedContext)
            
            articleObject.setValue(name, forKeyPath: "name")
            articleObject.setValue(readCount, forKeyPath: "readCount")
            articleObject.setValue(totalTimeSpent, forKeyPath: "timeSpent")
            articleObject.setValue(url, forKeyPath: "url")
        }
        else{
            model?.name = name
            model?.timeSpent = totalTimeSpent
            model?.readCount = readCount
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    private func findCoreDataModel(url:String)->ArticleCD?{
        let articles:[ArticleCD] = CoreDataManager.shared.getList()
        
        for article in articles{
            if(article.url! == url){
                return article
            }
        }
        
        return nil
    }
    
    func equal(article:ArticleModel)->Bool{
        if(article.url == self.url){
            return true
        }
        return false
    }
}
