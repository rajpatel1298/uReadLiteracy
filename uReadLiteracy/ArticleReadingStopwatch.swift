//
//  ArticleReadingTimer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/11/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class ArticleReadingStopwatch{
    
    private var startDate:Date!
    private let article:ArticleModel
    
    init(article:ArticleModel){
        self.article = article
    }
        
    func start(){
        startDate = Date()
    }
    
    func stop(){
        let stopDate = Date().timeIntervalSince(startDate)
        article.timeSpent = stopDate
    }
}
