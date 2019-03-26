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
    
    func getModels(category:ArticleCategory)->[ArticleModel]{
        let fileURL = Bundle.main.url(forResource: category.rawValue, withExtension: "txt")
        do{
            let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
            return getArticleFromText(content: content, category: .Art)
        }
        catch{
            return []
        }
    }
    
    func getCategories()->[String]{
        return [ArticleCategory]
    }
    
    
    
    private func getArticleFromText(content:String, category:ArticleCategory)->[ArticleModel]{
        var articles = [ArticleModel]()
        
        for line in content.components(separatedBy: "\n"){
            let line = line.replacingOccurrences(of: "\r", with: "")
            let titleAndLink = line.components(separatedBy: ": ")
            if(titleAndLink.count < 2){
                continue
            }
            
            let title = titleAndLink[0]
            let link = titleAndLink[1]
            
            articles.append(ArticleModel(name: title, url: link, category: category))
            
        }
        return articles
    }
}
