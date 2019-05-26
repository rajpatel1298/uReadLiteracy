//
//  ReadArticleAchievement.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 5/25/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class ArticleAchievement:Achievement{
    var articlesRead:Int
    
    init(title:String,quote:String?,image : UIImage,articlesRead:Int){
        self.articlesRead = articlesRead
        super.init(title: title, quote: quote, image: image)
    }
}
