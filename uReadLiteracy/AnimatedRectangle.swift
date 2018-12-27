//
//  AnimatedRectangle.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 12/26/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class AnimatedRectangle{
    let layer = CAShapeLayer()
    
    init(topLeft:CGPoint, view:UIView, width:CGFloat,height:CGFloat){
        let path = UIBezierPath()
        path.move(to: topLeft)
        path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        path.addLine(to: CGPoint(x: topLeft.x + width, y: topLeft.y))
        path.addLine(to: CGPoint(x: topLeft.x + width, y: topLeft.y + height))
        path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y + height))
        path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        
        path.close()
        
        
        layer.path = path.cgPath
        
        // Set up the appearance of the shape layer
        layer.strokeEnd = 0
        layer.lineWidth = 5
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.clear.cgColor
        
        view.layer.addSublayer(layer)
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
        layer.add(animation, forKey: "line")
    }
}
