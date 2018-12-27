//
//  BouncingLabel.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 12/26/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class BouncingLabel:UILabel{
    private var string: String!
    init(string:String, frame:CGRect){
        self.string = string
        super.init(frame: frame)
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.string = ""
    }
}
