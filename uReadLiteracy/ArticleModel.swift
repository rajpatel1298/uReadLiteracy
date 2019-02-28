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
    var name:String
    var readCount:Double
    
    // 1 unit = 1 second
    var timeSpent:Double = 0
    
    let url:String

  
    init(name:String,readCount:Double,url:String){
        self.name = name
        self.readCount = readCount
        self.url = url
        
        fixNameParsing()
    }
    
    init(name:String,url:String){
        self.name = name
        self.url = url
        
        let model:ArticleModel? = ArticleManager.shared.find(url: url)
        
        if(model == nil){
            self.readCount = 0
        }
        else{
            self.readCount = (model?.readCount)!
        }
        
        fixNameParsing()
    }
    
    func getTitle()->String{
        return name
    }
    
    private func fixNameParsing(){
        name = name.replacingOccurrences(of: "Text & MP3 File", with: "")
    }
    
    func incrementReadCount(){
        readCount = readCount + 1
        CoreDataSaver.shared.save(articleModel: self)
    }
    
    func equal(article:ArticleModel)->Bool{
        if(article.url == self.url){
            return true
        }
        return false
    }
}
