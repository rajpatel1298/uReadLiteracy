//
//  ChildWebPage.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 10/23/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation

class ChildWebPage: ParentWebPage{
    private let parentUrlString:String
    
    init(urlString: String,parentUrlString:String) {
        self.parentUrlString = parentUrlString
        super.init(urlString: urlString)
        fixURLIfNeeded()
        
    }
    
    private func fixURLIfNeeded(){
        if(urlString.contains("applewebdata://")){
            urlString = urlString.replacingOccurrences(of: "applewebdata://", with: "")
            
            var i = 0
            while(i < urlString.count){
                if(urlString[urlString.index(urlString.startIndex, offsetBy: i)] == "/"){
                    i = i + 1
                    break
                }
                
                i = i + 1
            }
            urlString.removeFirst(i)
            urlString = parentUrlString + urlString
        }
    }
}
