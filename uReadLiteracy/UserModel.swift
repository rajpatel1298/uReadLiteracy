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
import FirebaseAuth
import FirebaseStorage

class UserModel{
    private var image:UIImage?
    private var nickname:String?
    var uid:String!
    var email:String!
    var password:String!
    
    static var sharedInstance = UserModel()
    private let storage = Storage.storage()
    
    private init(){
        let managedContext = CoreDataHelper.sharedInstance.getManagedContext()
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserCD")
        let users = try! managedContext.fetch(userFetch)
        
        if(users.count > 0){
            let onlyUser = users.first as! UserCD
            if onlyUser.image != nil{
                image = UIImage(data: onlyUser.image as! Data)
            }
            
            nickname = onlyUser.nickname
        }
    }
    
    static func createUser(image:UIImage?, nickname: String, completionHandler:@escaping (_ state:UIState)->Void){
        let tempId = UUID().uuidString
        let email = "\(tempId)@gmail.com"
        let password = tempId
        
        sharedInstance.email = email
        sharedInstance.password = password
        sharedInstance.nickname = nickname
        sharedInstance.image = image
        
        Auth.auth().createUser(withEmail: email, password: password) { (_, err) in
            if err == nil{
                sharedInstance.uid = Auth.auth().currentUser?.uid
                
                sharedInstance.saveUserImageToFirebaseStorage(completionHandler: { (state) in
                    switch(state){
                    case .Success:
                        self.sharedInstance.saveToCoreData()
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
    
    private func saveToCoreData(){
        let managedContext = CoreDataHelper.sharedInstance.getManagedContext()
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
    
    
    
    func getImage()->UIImage?{
        return image
    }
    
    func getNickname()->String{
        return nickname!
    }
}

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return UIImageJPEGRepresentation(self, quality.rawValue)
    }
}
