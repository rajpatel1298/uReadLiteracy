//
//  UserModel.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/22/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UserModel{
    private var image:UIImage?
    private var nickname:String?
    
    init(){
        let managedContext = CoreDataHelper.sharedInstance.getManagedContext()
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let users = try! managedContext.fetch(userFetch)
        let onlyUser = users.first as! User
        
        image = UIImage(data: onlyUser.image as! Data)
        nickname = onlyUser.nickname
    }
    
    func save(image:UIImage, nickname: String){
        let managedContext = CoreDataHelper.sharedInstance.getManagedContext()
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
    
    func getImage()->UIImage{
        if(image == nil){
            fatalError("User not saved")
        }
        return image!
    }
    
    func getNickname()->String{
        return nickname!
    }
}
