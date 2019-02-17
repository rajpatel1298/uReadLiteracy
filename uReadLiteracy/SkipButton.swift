//
//  SkipButton.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/16/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class SkipButton:RoundedButton{
    override func layoutSubviews() {
        super.layoutSubviews()
        setTitle("Skip", for: .normal)
        setTitleColor(UIColor.lightGray, for: .normal)
        backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
    }
}
