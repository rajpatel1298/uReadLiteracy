//
//  AnimatedRectangle.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 12/26/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class AnimatedRectangle:CAShapeLayer{
    
    init(topLeft:CGPoint, width:CGFloat,height:CGFloat){
        super.init()
        resetPath(topLeft: topLeft, width: width, height: height)
        
        
        // Set up the appearance of the shape layer
        self.strokeEnd = 0
        self.lineWidth = 5
        self.strokeColor = UIColor.black.cgColor
        self.fillColor = UIColor.clear.cgColor
    }
    
    func resetPath(topLeft:CGPoint, width:CGFloat,height:CGFloat){
        let path = UIBezierPath()
        path.move(to: topLeft)
        path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        path.addLine(to: CGPoint(x: topLeft.x + width, y: topLeft.y))
        path.addLine(to: CGPoint(x: topLeft.x + width, y: topLeft.y + height))
        path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y + height))
        path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        
        path.close()
        
        self.path = path.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func animate(){
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 2 // seconds
        animation.autoreverses = false
        animation.repeatCount = 0
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        // And finally add the linear animation to the shape!
        self.add(animation, forKey: "line")
    }
}
