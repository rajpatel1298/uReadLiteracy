//
//  CategoryAchievement.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 5/25/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

import UIKit

class CategoryAchievement:Achievement{
    var categoryRead:Int
    
    init(title:String,quote:String?,image : UIImage,categoryRead:Int, completed:Bool){
        self.categoryRead = categoryRead
        super.init(title: title, quote: quote, image: image, completed: completed)
    }
}
