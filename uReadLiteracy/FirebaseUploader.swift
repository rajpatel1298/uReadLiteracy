//
//  FirebaseUploader.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/28/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseUploader{
    static let shared = FirebaseUploader()
    
    private let ref = Database.database().reference()
    
    func upload(comment:ArticleComment){
        let now = Date().toStringWithoutSpace()
        
        let path = "\(comment.articleName )/\(comment.uid!)/\(now)"
        let uploadDic = ["username":comment.username,"comment":comment.comment]
        
        ref.child(path).setValue(uploadDic)
    }
}
