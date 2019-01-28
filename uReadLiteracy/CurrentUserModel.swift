//
//  CurrentUserModel.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/22/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import FirebaseAuth
import FirebaseStorage

class CurrentUserModel:CoreDataModelHandler{
    private var image:UIImage?
    private var nickname:String!
    private var uid:String!
    private var email:String!
    private var password:String!
    
    private let storage = Storage.storage()
        
    override init(){
        super.init()
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserCD")
        let users = try! managedContext.fetch(userFetch)
        
        if(users.count > 0){
            let onlyUser = users.first as! UserCD
            if onlyUser.image != nil{
                image = UIImage(data: onlyUser.image as! Data)
            }
            uid = onlyUser.uid
            email = onlyUser.email!
            nickname = onlyUser.nickname
        }
    }
    
    func createUser(image:UIImage?, nickname: String, completionHandler:@escaping (_ state:UIState)->Void){
        self.nickname = nickname
        self.image = image
        
        let tempId = UUID().uuidString
        email = "\(tempId)@gmail.com"
        password = tempId
        
        Auth.auth().createUser(withEmail: email, password: password) { (_, err) in
            if err == nil{
                self.uid = Auth.auth().currentUser?.uid
                
                self.saveUserImageToFirebaseStorage(completionHandler: { (state) in
                    switch(state){
                    case .Success:
                        self.save()
                        completionHandler(.Success)
                        break
                    case .Failure(let err):
                        completionHandler(.Failure(err))
                        break
                    default:
                        break
                    }
                })
                
            }
            else{
                completionHandler(.Failure((err?.localizedDescription)!))
            }
        }
    }
    
    internal override func save(){
        let userEntity = NSEntityDescription.entity(forEntityName: "UserCD", in: managedContext)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        user.setValue(nickname, forKeyPath: "nickname")
        user.setValue(uid, forKeyPath: "uid")
        user.setValue(email, forKeyPath: "email")
        user.setValue(password, forKeyPath: "password")
        
        if image != nil {
            let data = UIImagePNGRepresentation(image!)
            user.setValue(data, forKeyPath: "image")
        }

        do {
            try managedContext.save()
        } catch let error as NSError {
            fatalError("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    private func saveUserImageToFirebaseStorage(completionHandler:@escaping (_ state:UIState)->Void){
        if image == nil {
            completionHandler(.Success)
            return
        }
        
        let storageRef = storage.reference().child("profile")
        let imagesRef = storageRef.child("\(uid!).jpg")
        
        let data = image?.jpeg(.low)
        
        imagesRef.putData(data!, metadata: nil) { (_, err) in
            if err == nil{
                completionHandler(.Success)
            }
            else{
                completionHandler(.Failure(err.debugDescription))
            }
        }
    }
    
    func getUid()->String{
        return uid
    }
    
    func getImage()->UIImage?{
        return image
    }
    
    func getNickname()->String{
        return nickname!
    }
}


