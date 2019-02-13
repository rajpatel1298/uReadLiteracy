//
//  ArticleReadingTimer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/11/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class ArticleReadingTimer{
    // 1 unit = 1 second
    private var currentTimeSpent = 0.0
    private var timer = Timer()
    
    private let article:ArticleModel
    
    init(timerOn article:ArticleModel){
        self.article = article
    }
    
    func startRecordingTime(){
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(self.updateTimeSpent), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimeSpent() {
        currentTimeSpent = currentTimeSpent + 1
    }
    
    func stopRecordingTime(){
        timer.invalidate()
        article.totalTimeSpent += currentTimeSpent
        CoreDataGetter.shared.save(articleModel: article)
        
        currentTimeSpent = 0
    }
    
    func timeReadThisTimeInMinutes()->Int{
        return Int(currentTimeSpent/60)
    }
}
