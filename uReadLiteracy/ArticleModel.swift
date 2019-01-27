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
    private var totalTimeSpent:Double
    private var currentTimeSpent = 0.0
    
    private let url:String
    
    private var timer = Timer()
    
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
    
        let model:ArticleModel? = ArticleModel.find(url: url)
        
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
    
    func startRecordingTime(){
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(self.updateTimeSpent), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimeSpent() {
        totalTimeSpent = totalTimeSpent + 1
        currentTimeSpent = currentTimeSpent + 1
    }
    
    func stopRecordingTime(){
        save()
    }
    
    func incrementReadCount(){
        readCount = readCount + 1
        save()
    }
    
    func timeReadThisTimeInMinutes()->Int{
        return Int(currentTimeSpent/60)
    }
    
    internal override func save(){
        let model:ArticleCD? = ArticleModel.findCoreDataModel(url: url)
        
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
    
    private static func find(url:String)->ArticleModel?{
        let articleFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleCD")
        
        let articles = try! shared.managedContext.fetch(articleFetch) as! [ArticleCD]
        
        for article in articles{
            if(article.url! == url){
                return ArticleModel(name: article.name!, readCount: article.readCount, timeSpent: article.timeSpent, url: article.url!)
            }
        }
        
        return nil
    }
    
    private static func findCoreDataModel(url:String)->ArticleCD?{
        let articleFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleCD")
        
        let articles = try! shared.managedContext.fetch(articleFetch) as! [ArticleCD]
        
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
    
    static func getUrls(articles:[ArticleModel])->[String]{
        var arr = [String]()
        for article in articles{
            arr.append(article.url)
        }
        return arr
    }
    
    static func getArticles(from:[String])->[ArticleModel]{
        var arr = [ArticleModel]()
        for url in from{
            arr.append(ArticleModel.find(url: url)!)
        }
        return arr
    }
}
