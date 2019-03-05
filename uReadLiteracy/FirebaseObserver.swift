//
//  FirebaseObserver.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/1/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseObserver{
    private var query:DatabaseQuery!
    
    func observeComment(articleName:String,complete:@escaping (_ list:[ArticleComment])->Void){
        var commentList = [ArticleComment]()
        query = Database.database().reference().child(articleName).queryOrderedByKey()
        
        query!.observe(.value, with: { snapshot in
            let snapshotDic = snapshot.value as? [String:Any]
            
            if snapshotDic == nil{
                complete([ArticleComment]())
                return
            }
            
            for (key,value) in snapshotDic! {
                let commentUid = key
                
                let dict = value as! [String:[String:String]]
                
                for (dateAsString,commentDetail) in dict{
                    let commentString = commentDetail["comment"]
                    let username = commentDetail["username"]
                    
                    let comment = ArticleComment(articleName: articleName, uid: commentUid, username: username!, comment: commentString!, date: Date.get(string: dateAsString))
                    
                    commentList.append(comment)
                }
            }
            
            commentList.sort(by: { (c1, c2) -> Bool in
                return c1.date! > c2.date!
            })
            
            complete(commentList)
            
        })
    }
    
    deinit {
        if query != nil{
            query.removeAllObservers()
        }
    }
}
