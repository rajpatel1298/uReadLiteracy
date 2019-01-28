//
//  AudioRecordModel.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/27/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import CoreData

class AudioRecordModel:CoreDataModelHandler{
    private var path:String!
    private var title:String!
    private var date:Date!
    
    init(path:String,title:String,date:Date){
        self.path = path
        self.title = title
        self.date = date
    }
    
    func getTitle()->String{
        return title
    }
    
    func getDate()->Date{
        return date
    }
    
    override func save(){
        let model:AudioRecordCD? = nil
        
        if(model == nil){
            let entity = NSEntityDescription.entity(forEntityName: "AudioRecordCD", in: managedContext)!
            let object = NSManagedObject(entity: entity, insertInto: managedContext)
            
            object.setValue(path, forKeyPath: "path")
            object.setValue(title, forKeyPath: "title")
            object.setValue(date, forKeyPath: "date")
        }
        else{
            model?.path = path
            model?.title = title
            model?.date = date as! NSDate
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    private static func findCoreDataModel(path:String,title:String,date:Date)->AudioRecordCD?{
        let list:[AudioRecordCD] = CoreDataManager.shared.getList()
        
        for item in list{
            if(item.path == path && item.title == title && (item.date! as Date) == date){
                return item
            }
        }
        
        return nil
    }
    
    
}
