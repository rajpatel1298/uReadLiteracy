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

class CoreDataGetter{
    static let shared = CoreDataGetter()
    
    private var appDelegate:AppDelegate!
    private let managedContext:NSManagedObjectContext
        
    init(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func getList()->[HelpWordModel]{
        let wordFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "HelpWordCD")
        let words = try! managedContext.fetch(wordFetch) as! [HelpWordCD]
        
        var list = [HelpWordModel]()
        
        for word in words{
            let w = HelpWordModel(word: word.word!, timesAsked:Int(word.timesAsked),askedLastArticle:word.askedLastArticle)
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
    
    
    func find(helpWord:String)->HelpWordCD?{
        let words:[HelpWordCD] = getList()
        for word in words{
            if word.word == helpWord{
                return word
            }
        }
        return nil
    }
    
    func find(articleUrlToFind:String)->ArticleCD?{
        let list:[ArticleCD] = getList()
        for article in list{
            if article.url == articleUrlToFind{
                return article
            }
        }
        return nil
    }
    
    func getList()->[ArticleCD]{
        managedContext.refreshAllObjects()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleCD")
        fetchRequest.shouldRefreshRefetchedObjects = true
        
        let objects = try! managedContext.fetch(fetchRequest)
  
        return objects as! [ArticleCD]
    }
    
    func getList() -> [HelpWordCD] {
        managedContext.refreshAllObjects()
        let wordFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "HelpWordCD")
        wordFetch.shouldRefreshRefetchedObjects = true
        
        let words = try! managedContext.fetch(wordFetch) as! [HelpWordCD]
        return words
    }
    
}
