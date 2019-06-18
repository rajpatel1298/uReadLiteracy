//
//  RoundedTextView.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 6/5/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class RoundedTextView:UITextView{
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 10
        layer.masksToBounds = false
        clipsToBounds = true
    }
}
