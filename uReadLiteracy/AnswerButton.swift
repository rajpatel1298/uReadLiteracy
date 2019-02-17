//
//  AnswerButton.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/16/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class AnswerButton:RoundedButton{
    override func layoutSubviews() {
        super.layoutSubviews()
        setTitle("Answer", for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = UIColor.init(red: 255/255, green: 140/255, blue: 0/255, alpha: 1)
    }
}
