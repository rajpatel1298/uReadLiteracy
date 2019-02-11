//
//  RoundedImageView.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/11/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class RoundedImageView:UIImageView{
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 10
        layer.masksToBounds = false
        clipsToBounds = true
    }
}
