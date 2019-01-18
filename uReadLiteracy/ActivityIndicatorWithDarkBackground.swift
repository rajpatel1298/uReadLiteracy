//
//  ActivityIndicatorWithDarkBackground.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/18/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicatorWithDarkBackground:UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let darkLayer = CALayer()
        darkLayer.frame = frame
        darkLayer.backgroundColor = UIColor.black.cgColor
        darkLayer.opacity = 0.5
        
        
        self.layer.addSublayer(darkLayer)
        
        let activityIndicator = UIActivityIndicatorView(frame: frame)
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
        self.bringSubview(toFront: activityIndicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
