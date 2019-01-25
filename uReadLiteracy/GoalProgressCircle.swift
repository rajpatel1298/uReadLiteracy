//
//  GoalProgressCircle.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 12/25/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class GoalProgressCircle{
    private var loadingCircle:LoadingCircle!
    private let view:UIView
    private let pulsingLayer = CAShapeLayer()
    private var center:CGPoint!
    private let percent:Int
    private var width:CGFloat!
    private let loadingDuration:Double = 1
    private let numberOfColor = 360
    
    private var percentLabel:CountingLabel!
    private let trackPath = CAShapeLayer()
    
    init(percent:Int, center:CGPoint,width:CGFloat, view:UIView){
        self.center = center
        self.view = view
        self.percent = percent
        self.width = width
        
        setupLoadingCircle()
        setupPulseLayer()
        setupTrackPath()
        
        view.layer.addSublayer(trackPath)
        view.layer.addSublayer(pulsingLayer)
        view.layer.addSublayer(loadingCircle)
        
        
        percentLabel = CountingLabel(percent: percent, loadingDuration: loadingDuration)
         
        percentLabel.text = "0%"
        percentLabel.textAlignment = .center
        percentLabel.backgroundColor = UIColor.clear
        percentLabel.baselineAdjustment = .alignCenters
        percentLabel.font = UIFont(name: "NokioSans-Bold", size: 30)

        view.addSubview(percentLabel)
        view.bringSubview(toFront: percentLabel)
    }
    
    func animate(){
        addPulseAnimation()
        loadingCircle.animate()
        percentLabel.animate()
        
        addTrackPathAnimation()
    }
    
    func reset(center:CGPoint){
        pulsingLayer.removeFromSuperlayer()
        loadingCircle.removeFromSuperlayer()
        trackPath.removeFromSuperlayer()
        self.center = center
        setupLoadingCircle()
        setupPulseLayer()
        setupTrackPath()
        view.layer.addSublayer(pulsingLayer)
        view.layer.addSublayer(loadingCircle)
        
        percentLabel.frame = CGRect(x: center.x - width/2 , y: center.y - width/2 + 2, width: width, height: width)
        view.bringSubview(toFront: percentLabel)
    }
    
    private func addTrackPathAnimation(){
        let trackPathColorAnimation = CAKeyframeAnimation(keyPath: "strokeColor")
        trackPathColorAnimation.values = LoadingCircleColors.sharedInstance.getColorGroup(percent: percent, numberOfColorChange: numberOfColor)
        trackPathColorAnimation.duration = CFTimeInterval(loadingDuration)
        trackPathColorAnimation.keyTimes = (0 ... numberOfColor).map { NSNumber(value: CFTimeInterval($0) / CFTimeInterval(numberOfColor)) }
        trackPathColorAnimation.isRemovedOnCompletion = false
        trackPathColorAnimation.fillMode = kCAFillModeForwards
        
        trackPath.add(trackPathColorAnimation, forKey: nil)
    }
    
    private func addPulseAnimation(){
        let pulsingAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulsingAnimation.fromValue = 1.2
        pulsingAnimation.toValue = 1.3
        
        pulsingAnimation.duration = 1
        
        pulsingAnimation.autoreverses = true
        pulsingAnimation.repeatCount = .infinity
        
        pulsingLayer.add(pulsingAnimation, forKey: nil)
        
        let pulseColorAnimation = CAKeyframeAnimation(keyPath: "fillColor")
        pulseColorAnimation.values = LoadingCircleColors.sharedInstance.getColorGroup(percent: percent, numberOfColorChange: numberOfColor)
        pulseColorAnimation.duration = CFTimeInterval(loadingDuration)
        pulseColorAnimation.keyTimes = (0 ... numberOfColor).map { NSNumber(value: CFTimeInterval($0) / CFTimeInterval(numberOfColor)) }
        pulseColorAnimation.isRemovedOnCompletion = false
        pulseColorAnimation.fillMode = kCAFillModeForwards
        
        pulsingLayer.add(pulseColorAnimation, forKey: nil)
    }
    
    private func setupLoadingCircle(){
        loadingCircle = LoadingCircle(position: center,radius: width/2, percent: percent, loadingDuration: loadingDuration, numberOfColor: numberOfColor)
    }
    
    private func setupPulseLayer(){
        pulsingLayer.path = loadingCircle.path
        pulsingLayer.fillColor = UIColor.clear.cgColor
        pulsingLayer.opacity = 0.5
        pulsingLayer.position = center
    }
    
    private func setupTrackPath(){
        trackPath.path = loadingCircle.path
        trackPath.fillColor = UIColor.red.cgColor
        trackPath.lineCap = kCALineCapRound
        trackPath.lineWidth = 10
        trackPath.position = center
        trackPath.opacity = 0.5
        view.layer.addSublayer(trackPath)
    }
}
