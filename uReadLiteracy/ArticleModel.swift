//
//  ArticleModel.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/23/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import CoreData

class ArticleModel{
    private var name:String
    private var readCount:Double
    
    // 1 unit = 1 second
    private var timeSpent:Double
    private let url:String
    
    private var timer = Timer()
    
    init(name:String,readCount:Double,timeSpent:Double,url:String){
        self.name = name
        self.readCount = readCount
        self.timeSpent = timeSpent
        self.url = url
        
        fixNameParsing()
    }
    
    init(name:String,url:String){
        self.name = name
        self.url = url
        
        let model:ArticleModel? = ArticleModel.find(url: url)
        
        if(model == nil){
            self.readCount = 0
            self.timeSpent = 0
        }
        else{
            self.readCount = (model?.readCount)!
            self.timeSpent = (model?.timeSpent)!
        }
        
        fixNameParsing()
    }
    
    private func fixNameParsing(){
        name = name.replacingOccurrences(of: "Text & MP3 File", with: "")
    }
    
    func startRecordingTime(){
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(self.updateTimeSpent), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimeSpent() {
        timeSpent = timeSpent + 1
    }
    
    func stopRecordingTime(){
        save()
    }
    
    func incrementReadCount(){
        readCount = readCount + 1
        save()
    }
    
    func save(){
        let managedContext = CoreDataHelper.sharedInstance.getManagedContext()
        
        let model:Article? = ArticleModel.find(url: url)
        
        if(model == nil){
            let articleEntity = NSEntityDescription.entity(forEntityName: "Article", in: managedContext)!
            let articleObject = NSManagedObject(entity: articleEntity, insertInto: managedContext)
            
            articleObject.setValue(name, forKeyPath: "name")
            articleObject.setValue(readCount, forKeyPath: "readCount")
            articleObject.setValue(timeSpent, forKeyPath: "timeSpent")
            articleObject.setValue(url, forKeyPath: "url")
        }
        else{
            model?.name = name
            model?.timeSpent = timeSpent
            model?.readCount = readCount
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func find(url:String)->ArticleModel?{
        let managedContext = CoreDataHelper.sharedInstance.getManagedContext()
        let articleFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        
        let articles = try! managedContext.fetch(articleFetch) as! [Article]
        
        for article in articles{
            if(article.url! == url){
                return ArticleModel(name: article.name!, readCount: article.readCount, timeSpent: article.timeSpent, url: article.url!)
            }
        }
        
        return nil
    }
    
    static func find(url:String)->Article?{
        let managedContext = CoreDataHelper.sharedInstance.getManagedContext()
        let articleFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        
        let articles = try! managedContext.fetch(articleFetch) as! [Article]
        
        for article in articles{
            if(article.url! == url){
                return article
            }
        }
        
        return nil
    }
}
