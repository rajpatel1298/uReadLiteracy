//
//  ResponseTextField.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/16/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class ResponseTextView:UITextView{
    override func layoutSubviews() {
        super.layoutSubviews()
        text = "Type Your Answer"
        textColor = UIColor.lightGray
        backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        isEditable = true
    }
}
