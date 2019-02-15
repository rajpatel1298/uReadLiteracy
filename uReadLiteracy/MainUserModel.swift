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

class MainUserModel{
    var image:UIImage?
    var nickname:String!
    var uid:String!
    var email:String!
    var password:String!
    
    private let storage = Storage.storage()
        
    init(){
        let user = CoreDataGetter.shared.getMainUser()
        
        if let user = user{
            if user.image != nil{
                image = UIImage(data: user.image! as Data)
            }
            uid = user.uid
            email = user.email!
            nickname = user.nickname
        }
    }
    
    func createUser(image:UIImage?, nickname: String, completionHandler:@escaping (_ state:State)->Void){
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
                        CoreDataSaver.shared.save(model: self)
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
    
    private func saveUserImageToFirebaseStorage(completionHandler:@escaping (_ state:State)->Void){
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


