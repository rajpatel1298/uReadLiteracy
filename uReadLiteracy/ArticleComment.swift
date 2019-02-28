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
    let articleName:String
    let uid:String!
    let username:String
    let comment:String
    let date:Date?
    var userImage:UIImage?
    
    init(articleName:String,uid:String,username:String,comment:String){
        self.articleName = articleName
        self.uid = uid
        self.username = username
        self.comment = comment
        self.date = Date()
        
        FirebaseDownloader.shared.getImage(fromComment: self) { (image) in
            self.userImage = image
        }
    }
    
    init(articleName:String,uid:String,username:String,comment:String, date:Date){
        self.articleName = articleName
        self.uid = uid
        self.username = username
        self.comment = comment
        self.date = date
        
        FirebaseDownloader.shared.getImage(fromComment: self) { (image) in
            self.userImage = image
        }
    }
}
