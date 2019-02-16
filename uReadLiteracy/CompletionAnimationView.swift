//
//  CompletionAnimationView.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/15/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class CompletionAnimationView:LOTAnimationView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        animationSpeed = 1.5
        setAnimation(named: "3779-starts-transparent")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
