//
//  FirebaseDownloader.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/28/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import FirebaseStorage

class FirebaseDownloader{
    static let shared = FirebaseDownloader()
    
    private let storageRef = Storage.storage().reference()
    
    func getImage(fromComment:ArticleComment,completionHandler:@escaping (_ image:UIImage?)->Void){
        let comment = fromComment
        
        let imageRef = storageRef.child("profile/\(comment.uid!).jpg")
        
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
}
