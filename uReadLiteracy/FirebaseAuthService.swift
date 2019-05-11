//
//  FirebaseAuthService.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/4/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseAuthService{
    static let shared = FirebaseAuthService()
    
    func createUser(user:CurrentUser, completionHandler:@escaping (_ state:State)->Void){
        
        
        Auth.auth().createUser(withEmail: user.email, password: user.password) {(_, err) in
            if err == nil{
                user.uid = Auth.auth().currentUser?.uid
                
                FirebaseUploader.shared.uploadUserImage(image: user.image, uid: user.uid, completionHandler: { (state) in
                    
                    switch(state){
                    case .Success:
                        CoreDataUpdater.shared.save(model: user)
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
}
