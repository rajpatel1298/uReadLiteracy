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

class CurrentUser{
    var image:UIImage?
    var nickname:String!
    var uid:String!
    var email:String!
    var password:String!
    
    static let shared = CurrentUser()
        
    private init(){
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


