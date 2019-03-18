//
//  URLManager.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/17/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class URLManager{
    static let shared = URLManager()
    
    func get(urlString:String, completion:@escaping (Data?)->Void){
        
        guard let url = URL(string: urlString) else{
            completion(nil)
            return
        }
        
        let defaultSession = URLSession(configuration: .default)
        let dataTask = defaultSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print("DataTask error: " + error.localizedDescription + "\n")
                completion(nil)
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                completion(data)
            }
        }
        dataTask.resume()
    }
}
