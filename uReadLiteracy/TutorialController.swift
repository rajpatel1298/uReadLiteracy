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
    
    private var previousLayer = CAShapeLayer()

    private let tutorialView = UIView(frame: .zero)
    private let handAnimationView = AnimationView(name: "hand_click_gesture")
    
    private let audio:TutorialAudio
    private var gestureAdded = false
    
    private var gesture:UITapGestureRecognizer!
    
    var onComplete:()->Void = {}
    
    var steps = [()->()]()
    
    init(audio:TutorialAudio, vc:UIViewController){
        self.audio = audio
        self.vc = vc
        
        tutorialView.isUserInteractionEnabled = true
        tutorialView.addSubview(handAnimationView)
    
        handAnimationView.loopMode = .autoReverse
    }
    
    func setHandAnimationColorBlack(){
        handAnimationView.animation = Animation.named("black_hand_click_gesture")
    }
    
    func setHandAnimationColorWhite(){
        handAnimationView.animation = Animation.named("hand_click_gesture")
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
        vc.view.addSubview(tutorialView)
        
        tutorialView.alpha = 0
        
        UIView.animate(withDuration: 1) {
            self.tutorialView.alpha = 1
            self.steps.removeFirst()()
        }
    }
    
    private func doNextStep(){
        // still have more steps
        if steps.count > 0{
            steps.removeFirst()()
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
    
    func setHandAnimationPosition(frame:CGRect){
        let handSize = vc.view.frame.width/5
        UIView.animate(withDuration: 0.5) {
            self.handAnimationView.frame = CGRect(x: frame.origin.x + frame.width/2 - handSize/2, y: frame.origin.y, width: handSize, height: handSize)
        }
    }
    
    func showHighlightFrame(frame:CGRect){
        previousLayer.removeFromSuperlayer()
        
        let path = UIBezierPath(rect: vc.view.frame)
        
        let highlightPath = UIBezierPath(roundedRect: frame, cornerRadius: 5)
        
        path.append(highlightPath)
        path.usesEvenOddFillRule = true
        
        let fillLayer = CAShapeLayer()
        
        fillLayer.path = path.cgPath
        fillLayer.fillRule = CAShapeLayerFillRule.evenOdd
        
        fillLayer.fillColor = UIColor.black.cgColor
        fillLayer.opacity = 0.8
        
        previousLayer = fillLayer
        tutorialView.layer.addSublayer(fillLayer)
        
        runAnimation()
    }
    
    private func runAnimation(){
        tutorialView.bringSubviewToFront(handAnimationView)
        
        audio.playNextAudio()
        handAnimationView.play()
    }
}





