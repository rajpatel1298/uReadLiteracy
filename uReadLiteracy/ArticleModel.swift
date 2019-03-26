//
//  ArticleModel.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/23/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import CoreData

class ArticleModel{
    private var name:String
    let category:ArticleCategory
   
    // 1 unit = 1 second
    var timeSpent:Double = 0
    let url:String

  
    init(name:String,url:String,category:ArticleCategory){
        self.name = name.replacingOccurrences(of: "Text & MP3 File", with: "")
        self.url = url
        self.category = category
    }
    
    func getTitle()->String{
        return name
    }
    
    func equal(article:ArticleModel)->Bool{
        if(article.url == self.url){
            return true
        }
        return false
    }
}
