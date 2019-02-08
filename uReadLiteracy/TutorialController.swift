//
//  Tutorial.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/11/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class TutorialController{
    private let vc:UIViewController
    
    var tutorialLayers = [CAShapeLayer]()
    private var previousLayer = CAShapeLayer()
    private var handPositions = [CGRect]()
    
    private let tutorialView = UIView(frame: .zero)
    private let handAnimationView = LOTAnimationView(name: "hand_click_gesture")
    
    private let audio:TutorialAudio
    private var gestureAdded = false
    
    private var gesture:UITapGestureRecognizer!
    
    var onComplete:()->Void = {}
    
    init(audio:TutorialAudio, vc:UIViewController){
        self.audio = audio
        self.vc = vc
        
        tutorialView.isUserInteractionEnabled = true
        tutorialView.addSubview(handAnimationView)
        
        handAnimationView.loopAnimation = true
        handAnimationView.autoReverseAnimation = true
    }
    
    func setHandAnimationColorBlack(){
        handAnimationView.animation = "black_hand_click_gesture"
    }
    
    func setHandAnimationColorWhite(){
        handAnimationView.animation = "hand_click_gesture"
    }
    
    func tapped(){
        doNextStep()
    }
    func addGesture(gesture:UITapGestureRecognizer){
        self.gesture = gesture
        tutorialView.addGestureRecognizer(gesture)
        gestureAdded = true
    }
    
    func removeGesture(){
        tutorialView.removeGestureRecognizer(gesture)
    }
    
    func show(onComplete:@escaping ()->Void){
        if !gestureAdded{
            fatalError("need to use gestureAdded function")
        }
        
        self.onComplete = onComplete
        
        tutorialView.frame = vc.view.frame
        
        handAnimationView.frame = handPositions.first!
        
        vc.view.addSubview(tutorialView)
        
        tutorialView.alpha = 0
        
        UIView.animate(withDuration: 1) {
            self.tutorialView.alpha = 1
            self.doNextStep()
        }
    }
    
    private func doNextStep(){
        // still have more steps
        if tutorialLayers.count > 0{
            previousLayer.removeFromSuperlayer()
            
            let layer = tutorialLayers.remove(at: 0)
            previousLayer = layer
            tutorialView.layer.addSublayer(layer)
            
            tutorialView.bringSubview(toFront: handAnimationView)
            
            handAnimationView.frame = handPositions.removeFirst()
            
            audio.playNextAudio()
            handAnimationView.play()
        }
        // no more steps
        else{
            self.tutorialView.alpha = 1
            UIView.animate(withDuration: 1, animations: {
                self.tutorialView.alpha = 0
            }) { (_) in
                self.tutorialView.removeFromSuperview()
                self.previousLayer.removeFromSuperlayer()
                self.onComplete()
            }
        }
    }
    
    func setHandAnimationPosition(x: CGFloat, y: CGFloat){
        let handSize = vc.view.frame.width/5
        handAnimationView.frame = CGRect(x: x/2 - handSize/2, y: y/2 - handSize/2, width: handSize, height: handSize)
        
        
    }
    
    func highlightFrame(frame:CGRect){
        let handSize = vc.view.frame.width/5
        let handPosition = CGRect(x: frame.origin.x + frame.width/2 - handSize/2, y: frame.origin.y, width: handSize, height: handSize)
        handPositions.append(handPosition)
        
        let path = UIBezierPath(rect: vc.view.frame)
        
        let highlightPath = UIBezierPath(roundedRect: frame, cornerRadius: 5)
        
        path.append(highlightPath)
        path.usesEvenOddFillRule = true
        
        let fillLayer = CAShapeLayer()
        
        fillLayer.path = path.cgPath
        fillLayer.fillRule = kCAFillRuleEvenOdd
        
        fillLayer.fillColor = UIColor.black.cgColor
        fillLayer.opacity = 0.8
        
        tutorialLayers.append(fillLayer)
        
        
    }
}





