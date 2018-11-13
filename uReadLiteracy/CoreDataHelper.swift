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

class CoreDataHelper{
    static var sharedInstance = CoreDataHelper()
    
    private var appDelegate:AppDelegate!
    
    init(){
        setup()
    }
    
    private func setup(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
    }
    
    func saveUserFirstTimeInfo(image:UIImage, nickname: String){
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        user.setValue(nickname, forKeyPath: "nickname")
        
        let data = UIImagePNGRepresentation(image)
        user.setValue(data, forKeyPath: "image")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    /*func saveLoginInfo(email:String,password:String){
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(email, forKeyPath: "email")
        user.setValue(password, forKeyPath: "password")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }*/
    
    func getUser()->User{
        let managedContext = appDelegate.persistentContainer.viewContext
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        let users = try! managedContext.fetch(userFetch)
        
        let onlyUser = users.first as! User
        
        return onlyUser
    }
}
