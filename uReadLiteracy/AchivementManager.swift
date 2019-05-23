//
//  AchivementManager.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 5/23/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class AchivementManager{
    let title:String
    let quote:String?
    private var image = UIImage()
    
    private let articlesRead:Int
    private let minutesRead:Int
    private let categoryRead:Int
    
    init(title:String,quote:String?) {
        self.title = title
        self.quote = quote
        self.articlesRead = 0
        self.minutesRead = 0
        self.categoryRead = 0
        findAndSetImage()
    }
    
    init(title:String,quote:String?,articlesRead:Int,minutesRead:Int,categoryRead:Int) {
        self.title = title
        self.quote = quote
        self.articlesRead = articlesRead
        self.minutesRead = minutesRead
        self.categoryRead = categoryRead
        findAndSetImage()
    }
    
    private func findAndSetImage(){
        switch(title){
        case "Read 1 Article":
            image = UIImage(named: "read1article") ?? UIImage()
            break
        case "Read 5 Articles":
            image = UIImage(named: "read5article") ?? UIImage()
            break
        case "Read 10 Articles":
            image = UIImage(named: "read10article") ?? UIImage()
            break
        case "Read 25 Articles":
            image = UIImage(named: "read25article") ?? UIImage()
            break
        case "Read 50 Articles":
            image = UIImage(named: "read50article") ?? UIImage()
            break
        case "Read 75 Articles":
            image = UIImage(named: "read75article") ?? UIImage()
            break
        case "Read 100 Articles":
            image = UIImage(named: "read100article") ?? UIImage()
            break
        case "Read 10 Minutes":
            image = UIImage(named: "read10minutes") ?? UIImage()
            break
        case "Read 30 Minutes":
            image = UIImage(named: "read30minutes") ?? UIImage()
            break
        case "Read 1 Hour":
            image = UIImage(named: "read1hour") ?? UIImage()
            break
        case "Read 2 Hours":
            image = UIImage(named: "read2hour") ?? UIImage()
            break
        case "Read 5 Hours":
            image = UIImage(named: "read5hour") ?? UIImage()
            break
        case "Read 10 Hours":
            image = UIImage(named: "read10hour") ?? UIImage()
            break
        case "Read 20 Hours":
            image = UIImage(named: "read20hour") ?? UIImage()
            break
        case "Read 50 Hours":
            image = UIImage(named: "read50hour") ?? UIImage()
            break
        case "Read 75 Hours":
            image = UIImage(named: "read75hour") ?? UIImage()
            break
        case "Read 100 Hours":
            image = UIImage(named: "read100hour") ?? UIImage()
            break
            
        case "Read from 1 Category":
            image = UIImage(named: "readfrom1category") ?? UIImage()
            break
        case "Read from 2 Categories":
            image = UIImage(named: "readfrom2category") ?? UIImage()
            break
        case "Read from 3 Categories":
            image = UIImage(named: "readfrom3category") ?? UIImage()
            break
        case "Read from 5 Categories":
            image = UIImage(named: "readfrom5category") ?? UIImage()
            break
        case "Read from All Categories":
            image = UIImage(named: "readfromallcategory") ?? UIImage()
            break
        default:
            image = UIImage()
            break
        }
    }
}
