//
//  LoadingCircle.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 12/1/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class LoadingCircle:CAShapeLayer{
    private var percent:Int!
    private let loadingDuration:Double
    private let numberOfColor:Int
    
    init(position:CGPoint,radius:CGFloat,percent:Int,loadingDuration:Double, numberOfColor: Int){
        self.percent = percent
        self.loadingDuration = loadingDuration
        self.numberOfColor = numberOfColor
        super.init()
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: -CGFloat.pi/2, endAngle:-CGFloat.pi/2 + 2 * CGFloat.pi, clockwise: true)
        self.path = circularPath.cgPath
        
        self.fillColor = UIColor.white.cgColor
        self.strokeColor = UIColor.white.cgColor
        self.lineCap = kCALineCapRound
        self.lineWidth = 10
        self.strokeEnd = 0
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.loadingDuration = 1
        self.numberOfColor = 360
        super.init(coder: aDecoder)
    }
    
    func animate(){
        animateLoadingPath()
        animatePathColor()
    }
    
    private func animateLoadingPath(){
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.fromValue = 0
        pathAnimation.toValue = CGFloat(CGFloat(percent)/100)
        
        pathAnimation.duration = CFTimeInterval(loadingDuration)
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.fillMode = kCAFillModeForwards
        self.add(pathAnimation, forKey: nil)
    }
    private func animatePathColor(){
        let numberOfColors = 360
        
        let colors = LoadingCircleColors.sharedInstance.getColorGroup(percent: percent, numberOfColorChange: numberOfColors)
        
        let pathAnimationColor = CAKeyframeAnimation(keyPath: "strokeColor")
        pathAnimationColor.values = colors
        pathAnimationColor.duration = CFTimeInterval(loadingDuration)
        pathAnimationColor.keyTimes = (0 ... numberOfColors).map { NSNumber(value: CFTimeInterval($0) / CFTimeInterval(numberOfColors)) }
        pathAnimationColor.isRemovedOnCompletion = false
        pathAnimationColor.fillMode = kCAFillModeForwards
        self.add(pathAnimationColor, forKey: nil)
    }
}
