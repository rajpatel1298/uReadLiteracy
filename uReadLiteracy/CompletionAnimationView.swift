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

class CompletionAnimationView:UIView{
    private let animationView = AnimationView(animation: Animation.named("3779-starts-transparent"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        animationView.frame = frame
        
        animationView.backgroundColor = UIColor.clear
        animationView.animationSpeed = 1.5
        
        addSubview(animationView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
