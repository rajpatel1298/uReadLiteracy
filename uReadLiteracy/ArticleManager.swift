//
//  ArticleManager.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/11/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class ArticleManager{
    static var shared = ArticleManager()
    
    func getArticles(from urls:[String])->[ArticleModel]{
        var arr = [ArticleModel]()
        for url in urls{
            arr.append(find(url: url)!)
        }
        return arr
    }
    
    func find(url:String)->ArticleModel?{
        let articles:[ArticleCD] = CoreDataGetter.shared.getList()
        
        for article in articles{
            if(article.url! == url){
                return ArticleModel(name: article.name!, readCount: article.readCount, timeSpent: article.timeSpent, url: article.url!)
            }
        }
        
        return nil
    }
    
    func getUrls(articles:[ArticleModel])->[String]{
        var arr = [String]()
        for article in articles{
            arr.append(article.url)
        }
        return arr
    }
}
