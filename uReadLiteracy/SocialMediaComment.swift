//
//  SocialMediaComment.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/16/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import FirebaseDatabase

class SocialMediaComment{
    private let articleName:String
    private let uid:String
    private let username:String
    let comment:String
    private let date:Date
    
    private let ref = Database.database().reference()
    private static let ref = Database.database().reference()
    
    init(articleName:String,uid:String,username:String,comment:String){
        self.articleName = articleName
        self.uid = uid
        self.username = username
        self.comment = comment
        
        self.date = Date()
    }
    
    func uploadToFirebase(){
        ref.child(getFirebasePath()).setValue(getObjectAsDictionary())
    }
    
    private func getObjectAsDictionary()->[String:String]{
        return ["username":username,"comment":comment]
    }
    
    private func getFirebasePath()->String{
        let df = DateFormatter()
        df.dateFormat = "yyyyMMddhhmmss"
        let now = df.string(from: Date())
        
        return "\(articleName)/\(uid)/\(now)"
    }
    
    static func get(articleName:String,uid:String,completionHandler:@escaping ([SocialMediaComment])->Void){
        
        
        let path = "\(articleName)/\(uid)"
        
        ref.child(path).queryOrderedByKey().observeSingleEvent(of: .value,
            with: { snapshot in
                
                for snap in snapshot.children{
                    print(snap)
                }
        })
    }
}
