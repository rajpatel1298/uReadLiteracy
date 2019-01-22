//
//  AchivementView.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/21/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class AchivementView:UIView{
    private var contentView:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let darkLayer = CALayer()
        darkLayer.frame = frame
        darkLayer.backgroundColor = UIColor.black.cgColor
        darkLayer.opacity = 0.5
        
        self.layer.addSublayer(darkLayer)
        
        let horizontalSpace:CGFloat = 20
        let verticleSpace:CGFloat = 20
        
        
        contentView = UIView(frame: CGRect(x: horizontalSpace, y: self.frame.height + verticleSpace, width: self.frame.width - horizontalSpace*2, height: self.frame.height - verticleSpace*2))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
