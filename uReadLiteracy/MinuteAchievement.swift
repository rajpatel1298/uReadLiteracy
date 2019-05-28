//
//  ReadMinuteAchievement.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 5/25/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class MinuteAchievement:Achievement{
    var minutesRead:Int
    
    init(title:String,quote:String?,image : UIImage,minutesRead:Int, completed:Bool){
        self.minutesRead = minutesRead
        super.init(title: title, quote: quote, image: image, completed: completed)
    }
}
