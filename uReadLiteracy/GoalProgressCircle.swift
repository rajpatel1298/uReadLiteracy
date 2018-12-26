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
    private let center:CGPoint
    private let percent:Int
    private var width:CGFloat!
    private let loadingDuration = 3
    private let numberOfColor = 360
    
    init(percent:Int, center:CGPoint,width:CGFloat, view:UIView){
        self.center = center
        self.view = view
        self.percent = percent
        self.width = width
        
        setupLoadingCircle()
        setupPulseLayer()
        
        view.layer.addSublayer(pulsingLayer)
        view.layer.addSublayer(loadingCircle)
    }
    
    func animate(){
        addPulseAnimation()
        loadingCircle.animate()
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
        pulsingLayer.fillColor = UIColor.red.cgColor
        pulsingLayer.opacity = 0.5
        pulsingLayer.position = center
    }
    
    private func addTrackPath(){
        /*let trackPath = CAShapeLayer()
         trackPath.path = loading.path
         trackPath.strokeColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 1).cgColor
         trackPath.fillColor = UIColor.white.cgColor
         trackPath.lineCap = kCALineCapRound
         trackPath.lineWidth = 10
         trackPath.position = center
         view.layer.addSublayer(trackPath)*/
    }
}
