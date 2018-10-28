//
//  AllowedPage.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 10/24/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation

class AllowedPage{
    private static let allowedPages = ["http://www.manythings.org/voa/stories/"]
    
    static func check(url:String)->Bool{
        for page in allowedPages{
            if(url.contains(page)){
                return true
            }
        }
        
        return false
    }
}
