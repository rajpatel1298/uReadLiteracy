//
//  ReadXArticlesGoalModel.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/25/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation

class ReadXArticlesDailyGoal:DailyGoalModel{
    init(name: String, date: Date) {
        super.init(name: name, date: date, type: .ReadXArticles)
    }
}
