//
//  QuestionLabel.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/16/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class QuestionLabel:UILabel{
    
    override func layoutSubviews() {
        font = UIFont(name: "NokioSansAlt-Medium", size: 23)
        textAlignment = .center
        numberOfLines = 0
        
    }

}
