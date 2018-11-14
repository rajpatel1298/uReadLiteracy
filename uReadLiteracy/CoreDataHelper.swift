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
    
    func saveHelpWord(word:String){
        let managedContext = appDelegate.persistentContainer.viewContext
        let wordEntity = NSEntityDescription.entity(forEntityName: "HelpWord", in: managedContext)!
        
        let wordObject = NSManagedObject(entity: wordEntity, insertInto: managedContext)
        
        let beginningDifficult = HelpWordHelper.sharedInstance.beginningDifficult(word: word)
        let endingDifficult = HelpWordHelper.sharedInstance.endingDifficult(word: word)
        let blendDifficult = HelpWordHelper.sharedInstance.blendDifficult(word: word)
        let multisyllabicDifficult = HelpWordHelper.sharedInstance.multisyllabicDifficult(word: word)
        
        wordObject.setValue(word, forKeyPath: "word")
        wordObject.setValue(beginningDifficult, forKeyPath: "beginningDifficult")
        wordObject.setValue(endingDifficult, forKeyPath: "endingDifficult")
        wordObject.setValue(blendDifficult, forKeyPath: "blendDifficult")
        wordObject.setValue(multisyllabicDifficult, forKeyPath: "multisyllabicDifficult")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func saveUnsavedChanges(){
        let managedContext = appDelegate.persistentContainer.viewContext
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getWordList()->[HelpWord]{
        let managedContext = appDelegate.persistentContainer.viewContext
        let wordFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "HelpWord")
        
        let words = try! managedContext.fetch(wordFetch)
        return words as! [HelpWord]
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
