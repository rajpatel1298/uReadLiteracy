//
//  AchievementManager.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 5/23/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class AchievementManager{
    private var articlesRead = 0
    private var minutesRead = 0
    private var categoryRead = 0
    
    private var oldArticlesRead:ArticleAchievement?
    private var oldMinutesRead:MinuteAchievement?
    private var oldCategoryRead:CategoryAchievement?
    
    init(){
        getCurrentStats()
        oldArticlesRead = getCurrentArticleAchievement()
        oldMinutesRead = getCurrentMinutesAchievement()
        oldCategoryRead = getCurrentCategoryAchievement()
    }
    
    func getNewAchievements()->[Achievement]{
        getCurrentStats()
        
        let newArticlesRead = getCurrentArticleAchievement()
        let newMinutesRead = getCurrentMinutesAchievement()
        let newCategoryRead = getCurrentCategoryAchievement()
        
        var list = [Achievement]()
        
        if let oldArticlesRead = oldArticlesRead{
            if( oldArticlesRead.articlesRead < newArticlesRead!.articlesRead){
                list.append(newArticlesRead!)
                self.oldArticlesRead = newArticlesRead!
            }
        }
        else if(newArticlesRead != nil){
            list.append(newArticlesRead!)
            oldArticlesRead = newArticlesRead!
        }
        
        if let oldMinutesRead = oldMinutesRead{
            if(oldMinutesRead.minutesRead < newMinutesRead!.minutesRead){
                list.append(newMinutesRead!)
                self.oldMinutesRead = newMinutesRead!
            }
        }
        else if(newMinutesRead != nil){
            list.append(newMinutesRead!)
            oldMinutesRead = newMinutesRead!
        }
        
        if let oldCategoryRead = oldCategoryRead{
            if(oldCategoryRead.categoryRead < newCategoryRead!.categoryRead){
                list.append(newCategoryRead!)
                self.oldCategoryRead = newCategoryRead!
            }
        }
        else if newCategoryRead != nil{
            list.append(newCategoryRead!)
            oldCategoryRead = newCategoryRead!
        }
        
        return list
    }
    
    private func getCurrentStats(){
        let articleList:[ArticleCD] = CoreDataGetter.shared.getList()
        var categoriesDidNotRead = [String]()
        
        for category in ArticleCategory.allCases{
            categoriesDidNotRead.append(category.rawValue)
        }
        
        for article in articleList{
            var i = 0
            for category in categoriesDidNotRead{
                if(article.category == category){
                    categoriesDidNotRead.remove(at: i)
                    break
                }
                i = i + 1
            }
        }
        
        categoryRead = ArticleCategory.allCases.count - categoriesDidNotRead.count
        
        for article in articleList{
            minutesRead = minutesRead + Int(article.minutesRead)
        }
        articlesRead = articleList.count
    }
    
    func getAllReadXArticlesAchivements()->[Achievement]{
        var list = [Achievement]()
        
        if articlesRead >= 1 && articlesRead<5{
            list.append(ArticleAchievement(title: "Read 1 Article", quote: "Your First Article!", image: UIImage(named: "read1article") ?? UIImage(), articlesRead: 1))
        }
        else if articlesRead >= 5 && articlesRead < 10{
            list.append(ArticleAchievement(title: "Read 5 Articles", quote: "Beginner", image: UIImage(named: "read5article") ?? UIImage(), articlesRead: 5))
        }
        else if articlesRead >= 10 && articlesRead < 25{
            list.append(ArticleAchievement(title: "Read 10 Article", quote: "Vigorous Reader", image: UIImage(named: "read10article") ?? UIImage(), articlesRead: 10))
        }
        else if articlesRead >= 25 && articlesRead < 50{
            list.append(ArticleAchievement(title: "Read 25 Article", quote: "You Are Determined!", image: UIImage(named: "read25article") ?? UIImage(), articlesRead: 25))
        }
        else if articlesRead >= 50 && articlesRead < 75{
            list.append(ArticleAchievement(title: "Read 50 Article", quote: "Persistence is Victory!", image: UIImage(named: "read50article") ?? UIImage(), articlesRead: 50))
        }
        else if articlesRead >= 75 && articlesRead < 100{
            list.append(ArticleAchievement(title: "Read 75 Article", quote: "Tireless Reader", image: UIImage(named: "read75article") ?? UIImage(), articlesRead: 75))
        }
        else if(articlesRead >= 100) {
            
            list.append(ArticleAchievement(title: "Read 100 Article", quote: "Reading Wizard", image: UIImage(named: "read100article") ?? UIImage(), articlesRead: 100))
        }
    
        return list
    }
    
    func getCurrentArticleAchievement()->ArticleAchievement?{
        if(articlesRead < 1){
            return nil
        }
        if articlesRead >= 1 && articlesRead<5{
            return ArticleAchievement(title: "Read 1 Article", quote: "Your First Article!", image: UIImage(named: "read1article") ?? UIImage(), articlesRead: 1)
        }
        else if articlesRead >= 5 && articlesRead < 10{
            return ArticleAchievement(title: "Read 5 Articles", quote: "Beginner", image: UIImage(named: "read5article") ?? UIImage(), articlesRead: 5)
        }
        else if articlesRead >= 10 && articlesRead < 25{
            return ArticleAchievement(title: "Read 10 Article", quote: "Vigorous Reader", image: UIImage(named: "read10article") ?? UIImage(), articlesRead: 10)
        }
        else if articlesRead >= 25 && articlesRead < 50{
            return ArticleAchievement(title: "Read 25 Article", quote: "You Are Determined!", image: UIImage(named: "read25article") ?? UIImage(), articlesRead: 25)
        }
        else if articlesRead >= 50 && articlesRead < 75{
            return ArticleAchievement(title: "Read 50 Article", quote: "Persistence is Victory!", image: UIImage(named: "read50article") ?? UIImage(), articlesRead: 50)
        }
        else if articlesRead >= 75 && articlesRead < 100{
            return ArticleAchievement(title: "Read 75 Article", quote: "Tireless Reader", image: UIImage(named: "read75article") ?? UIImage(), articlesRead: 75)
        }
        else if(articlesRead >= 100) {
            return ArticleAchievement(title: "Read 100 Article", quote: "Reading Wizard", image: UIImage(named: "read100article") ?? UIImage(), articlesRead: 100)
        }
        else{
            fatalError("There is no other case")
        }
    }
    
    func getAllReadXMinutesAchivements()->[Achievement]{
        var list = [Achievement]()
        
        if minutesRead >= 10 && minutesRead < 30{
            list.append(MinuteAchievement(title: "Read 10 Minutes", quote: "First Impression", image: UIImage(named: "read10minutes") ?? UIImage(), minutesRead: 10))
        }
        else if minutesRead >= 30 && minutesRead < 60{
            list.append(MinuteAchievement(title: "Read 30 Minutes", quote: "You’re Doing It", image: UIImage(named: "read30minutes") ?? UIImage(), minutesRead: 30))
        }
        else if minutesRead >= 60 && minutesRead < 120{
            list.append(MinuteAchievement(title: "Read 1 Hour", quote: "Your First One Hour", image: UIImage(named: "read1hour") ?? UIImage(), minutesRead: 60))
        }
        else if minutesRead >= 120 && minutesRead < 300{
            list.append(MinuteAchievement(title: "Read 2 Hours", quote: "Focus", image: UIImage(named: "read2hour") ?? UIImage(), minutesRead: 120))
        }
        else if minutesRead >= 300 && minutesRead < 600{
            list.append(MinuteAchievement(title: "Read 5 Hours", quote: "Nice Job", image: UIImage(named: "read5hour") ?? UIImage(), minutesRead: 300))
        }
        else if minutesRead >= 600 && minutesRead < 1200{
            list.append(MinuteAchievement(title: "Read 10 Hours", quote: "Taste of Victory", image: UIImage(named: "read10hour") ?? UIImage(), minutesRead: 600))
        }
        else if minutesRead >= 1200 && minutesRead < 3000{
            list.append(MinuteAchievement(title: "Read 20 Hours", quote: "Champion", image: UIImage(named: "read20hour") ?? UIImage(), minutesRead: 1200))
        }
        else if minutesRead >= 3000 && minutesRead < 4500{
            list.append(MinuteAchievement(title: "Read 50 Hours", quote: "Perfectionist", image: UIImage(named: "read50hour") ?? UIImage(), minutesRead: 3000))
        }
        else if minutesRead >= 4500 && minutesRead < 6000{
            list.append(MinuteAchievement(title: "Read 75 Hours", quote: "To The Max", image: UIImage(named: "read75hour") ?? UIImage(), minutesRead: 4500))
        }
        else if minutesRead >= 6000{
            list.append(MinuteAchievement(title: "Read 100 Hours", quote: "Superhero", image: UIImage(named: "read100hour") ?? UIImage(), minutesRead: 6000))
        }
        return list
    }
    
    func getCurrentMinutesAchievement()->MinuteAchievement?{
        if(minutesRead < 10){
            return nil
        }
        if minutesRead >= 10 && minutesRead < 30{
            return MinuteAchievement(title: "Read 10 Minutes", quote: "First Impression", image: UIImage(named: "read10minutes") ?? UIImage(), minutesRead: 10)
        }
        else if minutesRead >= 30 && minutesRead < 60{
            return MinuteAchievement(title: "Read 30 Minutes", quote: "You’re Doing It", image: UIImage(named: "read30minutes") ?? UIImage(), minutesRead: 30)
        }
        else if minutesRead >= 60 && minutesRead < 120{
            return MinuteAchievement(title: "Read 1 Hour", quote: "Your First One Hour", image: UIImage(named: "read1hour") ?? UIImage(), minutesRead: 60)
        }
        else if minutesRead >= 120 && minutesRead < 300{
            return MinuteAchievement(title: "Read 2 Hours", quote: "Focus", image: UIImage(named: "read2hour") ?? UIImage(), minutesRead: 120)
        }
        else if minutesRead >= 300 && minutesRead < 600{
            return MinuteAchievement(title: "Read 5 Hours", quote: "Nice Job", image: UIImage(named: "read5hour") ?? UIImage(), minutesRead: 300)
        }
        else if minutesRead >= 600 && minutesRead < 1200{
            return MinuteAchievement(title: "Read 10 Hours", quote: "Taste of Victory", image: UIImage(named: "read10hour") ?? UIImage(), minutesRead: 600)
        }
        else if minutesRead >= 1200 && minutesRead < 3000{
            return MinuteAchievement(title: "Read 20 Hours", quote: "Champion", image: UIImage(named: "read20hour") ?? UIImage(), minutesRead: 1200)
        }
        else if minutesRead >= 3000 && minutesRead < 4500{
            return MinuteAchievement(title: "Read 50 Hours", quote: "Perfectionist", image: UIImage(named: "read50hour") ?? UIImage(), minutesRead: 3000)
        }
        else if minutesRead >= 4500 && minutesRead < 6000{
            return MinuteAchievement(title: "Read 75 Hours", quote: "To The Max", image: UIImage(named: "read75hour") ?? UIImage(), minutesRead: 4500)
        }
        else if minutesRead >= 6000{
            return MinuteAchievement(title: "Read 100 Hours", quote: "Superhero", image: UIImage(named: "read100hour") ?? UIImage(), minutesRead: 6000)
        }
        else{
            fatalError("There is no other case")
        }
    }
    
    func getAllCategoryAchivements()->[Achievement]{
        var list = [Achievement]()
        
        if categoryRead == 1{
            list.append(CategoryAchievement(title: "Read from 1 Category", quote: "Starter", image: UIImage(named: "readfrom1category") ?? UIImage(), categoryRead: 1))
        }
        else if categoryRead == 2{
            list.append(CategoryAchievement(title: "Read from 2 Categories", quote: "Learner", image: UIImage(named: "readfrom2category") ?? UIImage(), categoryRead: 2))
        }
        else if categoryRead == 3 || categoryRead == 4{
            list.append(CategoryAchievement(title: "Read from 3 Categories", quote: "Piece It Together", image: UIImage(named: "readfrom3category") ?? UIImage(), categoryRead: 3))
        }
        else if categoryRead == 5 {
            list.append(CategoryAchievement(title: "Read from 5 Categories", quote: "Knowledge is Power", image: UIImage(named: "readfrom5category") ?? UIImage(), categoryRead: 5))
        }
        else if categoryRead == 12{
            list.append(CategoryAchievement(title: "Read from All Categories", quote: "You’re wise", image: UIImage(named: "readfromallcategory") ?? UIImage(), categoryRead: 12))
        }
        return list
    }
    
    func getCurrentCategoryAchievement()->CategoryAchievement?{
        if(categoryRead == 0){
            return nil
        }
        if categoryRead == 1{
            return CategoryAchievement(title: "Read from 1 Category", quote: "Starter", image: UIImage(named: "readfrom1category") ?? UIImage(), categoryRead: 1)
        }
        else if categoryRead == 2{
            return CategoryAchievement(title: "Read from 2 Categories", quote: "Learner", image: UIImage(named: "readfrom2category") ?? UIImage(), categoryRead: 2)
        }
        else if categoryRead == 3 || categoryRead == 4{
            return CategoryAchievement(title: "Read from 3 Categories", quote: "Piece It Together", image: UIImage(named: "readfrom3category") ?? UIImage(), categoryRead: 3)
        }
        else if categoryRead == 5 {
            return CategoryAchievement(title: "Read from 5 Categories", quote: "Knowledge is Power", image: UIImage(named: "readfrom5category") ?? UIImage(), categoryRead: 5)
        }
        else if categoryRead == 12{
            return CategoryAchievement(title: "Read from All Categories", quote: "You’re wise", image: UIImage(named: "readfromallcategory") ?? UIImage(), categoryRead: 12)
        }
        else{
            fatalError("There is no other case")
        }
    }
    
}
