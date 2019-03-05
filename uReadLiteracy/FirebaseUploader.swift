//
//  FirebaseUploader.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/28/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class FirebaseUploader{
    static let shared = FirebaseUploader()
    
    private let ref = Database.database().reference()
    private let storage = Storage.storage()
    
    func upload(comment:ArticleComment){
        let now = Date().toStringWithoutSpace()
        
        let path = "\(comment.articleName )/\(comment.uid!)/\(now)"
        let uploadDic = ["username":comment.username,"comment":comment.comment]
        
        ref.child(path).setValue(uploadDic)
    }
    
    func uploadUserImage(image:UIImage?, uid:String, completionHandler:@escaping (_ state:State)->Void){
        if image == nil {
            completionHandler(.Success)
            return
        }
        
        let storageRef = storage.reference().child("profile")
        let imagesRef = storageRef.child("\(uid).jpg")
        
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
}
