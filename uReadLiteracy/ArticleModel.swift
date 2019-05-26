//
//  ArticleModel.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/23/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import CoreData

class ArticleModel:ReadingSource{
    
    let category:ArticleCategory
   
    var minutesRead:Int = 0
    let url:String
    
    private var startDate:Date!

  
    init(name:String,url:String,category:ArticleCategory, difficulty:ReadingDifficulty){
        self.category = category
        self.url = url
        
        let cleanName = name.replacingOccurrences(of: "Text & MP3 File", with: "")
                
        super.init(name: cleanName, difficulty: difficulty)
    }
    
    func startTimer(){
        startDate = Date()
    }
    
    func stopTimer(){
        let stopDate = Date().timeIntervalSince(startDate)
        minutesRead = minutesRead + Int(stopDate/60)
        print()
    }
    
    func equal(article:ArticleModel)->Bool{
        if(article.url == self.url){
            return true
        }
        return false
    }
}
