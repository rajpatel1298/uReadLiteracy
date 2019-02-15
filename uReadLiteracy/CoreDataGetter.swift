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

class CoreDataGetter: CoreDataGoalGetter{
    static let shared = CoreDataGetter()
    
    private var appDelegate:AppDelegate!
    private let managedContext:NSManagedObjectContext
    
    override init(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
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
    
    func find(url:String)->ArticleCD?{
        let articles:[ArticleCD] = getList()
        
        for article in articles{
            if(article.url! == url){
                return article
            }
        }
        
        return nil
    }
    
    func find(path:String,title:String,date:Date)->AudioRecordCD?{
        let list:[AudioRecordCD] = getList()
        
        for item in list{
            if(item.path == path && item.title == title && (item.date! as Date) == date){
                return item
            }
        }
        
        return nil
    }
    
    
    
    func getMainUser()->UserCD?{
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserCD")
        let users = try! managedContext.fetch(userFetch)
        
        if(users.count > 0){
            return users.first as! UserCD
        }
        return nil
    }
}
