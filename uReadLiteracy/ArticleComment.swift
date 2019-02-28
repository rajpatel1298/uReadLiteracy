//
//  SocialMediaComment.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/16/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class ArticleComment{
    private let articleName:String
    private let uid:String!
    private let username:String
    let comment:String
    let date:Date?
    var userImage:UIImage?
    
    private let dbRef = Database.database().reference()
    private let storageRef = Storage.storage().reference()
    
    init(articleName:String,uid:String,username:String,comment:String){
        self.articleName = articleName
        self.uid = uid
        self.username = username
        self.comment = comment
        self.date = Date()
        
        getImage { (image) in
            self.userImage = image
        }
    }
    
    init(articleName:String,uid:String,username:String,comment:String, date:Date){
        self.articleName = articleName
        self.uid = uid
        self.username = username
        self.comment = comment
        self.date = date
        
        getImage { (image) in
            self.userImage = image
        }
    }
    
    func getImage(completionHandler:@escaping (_ image:UIImage?)->Void){
        let imageRef = storageRef.child("profile/\(uid!).jpg")
        
        // Download in memory with a maximum allowed size of 10MB (10 * 1024 * 1024 bytes)
        imageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
            if let error = error {
                print(error.localizedDescription)
                completionHandler(nil)
            }
            else{
                let image = UIImage(data: data!)
                completionHandler(image)
            }
        }
        
    }
    
    func uploadToFirebase(){
        dbRef.child(getFirebasePath()).setValue(getObjectAsDictionary())
    }
    
    private func getObjectAsDictionary()->[String:String]{
        return ["username":username,"comment":comment]
    }
    
    private func getFirebasePath()->String{
        let now = Date().toStringWithoutSpace()
        return "\(articleName)/\(uid!)/\(now)"
    }
}
