//
//  Achivement.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 5/23/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class Achievement{
    let title:String
    let quote:String?
    let image : UIImage
    
    var completed:Bool
    
    init(title:String,quote:String?,image : UIImage,completed:Bool){
        self.title = title
        self.quote = quote
        self.image = image
        self.completed = completed
    }
}
