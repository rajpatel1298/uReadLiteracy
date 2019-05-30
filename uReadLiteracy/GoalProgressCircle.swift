//
//  GoalProgressCircle.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 12/25/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class GoalProgressCircle:UIView{
    private var loadingCircle:LoadingCircle!
    private let pulsingLayer = CAShapeLayer()
    private var percent:Int = 0
    private let loadingDuration:Double = 1
    private let numberOfColor = 360
    
    private var percentLabel:CountingLabel!
    private let trackPath = CAShapeLayer()
    
    init(percent:Int,frame:CGRect){
        self.percent = percent
        super.init(frame: frame)
        
        setupLoadingCircle()
        setupPercentLabel()
        reset()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        reset()
    }
    
    func animate(){
        addPulseAnimation()
        loadingCircle.animate()
        percentLabel.animate()
        
        addTrackPathAnimation()
    }
    
    func reset(){
        pulsingLayer.removeFromSuperlayer()
        loadingCircle.removeFromSuperlayer()
        trackPath.removeFromSuperlayer()

        setupLoadingCircle()
        setupPulseLayer()
        setupTrackPath()
        layer.addSublayer(pulsingLayer)
        layer.addSublayer(loadingCircle)
        
        percentLabel.frame = CGRect(x: 0 , y: 0, width: frame.width, height: frame.height)
        bringSubviewToFront(percentLabel)
    }
    
    private func addTrackPathAnimation(){
        let trackPathColorAnimation = CAKeyframeAnimation(keyPath: "strokeColor")
        trackPathColorAnimation.values = LoadingCircleColors.sharedInstance.getColorGroup(percent: percent, numberOfColorChange: numberOfColor)
        trackPathColorAnimation.duration = CFTimeInterval(loadingDuration)
        trackPathColorAnimation.keyTimes = (0 ... numberOfColor).map { NSNumber(value: CFTimeInterval($0) / CFTimeInterval(numberOfColor)) }
        trackPathColorAnimation.isRemovedOnCompletion = false
        trackPathColorAnimation.fillMode = CAMediaTimingFillMode.forwards
        
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
        pulseColorAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        pulsingLayer.add(pulseColorAnimation, forKey: nil)
    }
    
    private func setupPercentLabel(){
        percentLabel = CountingLabel(percent: percent, loadingDuration: loadingDuration)
        
        percentLabel.text = "0%"
        percentLabel.textAlignment = .center
        percentLabel.backgroundColor = UIColor.clear
        percentLabel.baselineAdjustment = .alignCenters
        percentLabel.font = UIFont(name: "NokioSans-Bold", size: 30)
        
        addSubview(percentLabel)
    }
    
    private func setupLoadingCircle(){
        loadingCircle = LoadingCircle(position: CGPoint(x: bounds.width/2, y: bounds.height/2),radius: bounds.width/4, percent: percent, loadingDuration: loadingDuration, numberOfColor: numberOfColor)
        
    }
    
    private func setupPulseLayer(){
        pulsingLayer.position = loadingCircle.position
        pulsingLayer.path = loadingCircle.path
        pulsingLayer.fillColor = UIColor.clear.cgColor
        pulsingLayer.opacity = 0.5

    }
    
    private func setupTrackPath(){
        trackPath.position = loadingCircle.position
        trackPath.path = loadingCircle.path
        trackPath.fillColor = UIColor.red.cgColor
        trackPath.lineCap = CAShapeLayerLineCap.round
        trackPath.lineWidth = 10

        trackPath.opacity = 0.5
        layer.addSublayer(trackPath)
    }
}
