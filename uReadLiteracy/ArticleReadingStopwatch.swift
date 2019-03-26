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
        
    func start(){
        startDate = Date()
    }
    
    
    func stop(article:ArticleModel){
        let stopDate = Date().timeIntervalSince(startDate)
        article.timeSpent = stopDate
    }
}
