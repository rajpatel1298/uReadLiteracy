//
//  ProfileViewControllerTutorial.swift
//  uReadLiteracy
//
//  Created by Raj Patel on 1/16/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit
import Lottie

// For other Tutorial Controller, just copied the same code, and change stuffs when noted
class ProfileViewControllerTutorial:Tutorial{
    private var tutorialLayers = [CAShapeLayer]()
    
    private var previousLayer = CAShapeLayer()
    private let goalVCFrame:CGRect
    private let vc: ProfileViewController
    private var onComplete:()->Void = {}
    private var tutorialView = UIView(frame: .zero)
    private var gestureAdded = false
    
    private let animationView = LOTAnimationView(name: "hand_click_gesture")
    
    
    // Change based on the audio that you will use
    private let audio = TutorialAudio(audioFiles: ["profileTutorial1","goalTutorial2"])
    
    // No need to change
    init(vc:ProfileViewController){
        self.vc = vc
        tutorialView.isUserInteractionEnabled = true
        tutorialView.addSubview(animationView)
        
        self.goalVCFrame = vc.view.frame
        super.init()
    }
    
    // No need to change
    override func addGesture(gesture:UITapGestureRecognizer){
        tutorialView.addGestureRecognizer(gesture)
        gestureAdded = true
    }
    
    // Change based on the number of steps
    override func show(onComplete:@escaping ()->Void){
        if !gestureAdded{
            fatalError("need to use gestureAdded function")
        }
        
        self.onComplete = onComplete
        
        tutorialView.frame = vc.view.frame
        
        let handSize = vc.view.frame.width/5
        animationView.frame = CGRect(x: vc.view.frame.width/2 - handSize/2, y: vc.view.frame.height/2 - handSize/2, width: handSize, height: handSize)
        
        // Change This part
        getFirstStepLayer()
        getSecondStepLayer()
        //
        
        vc.view.addSubview(tutorialView)
        
        tutorialView.alpha = 0
        
        UIView.animate(withDuration: 1) {
            self.tutorialView.alpha = 1
            self.doNextStep()
        }
    }
    
    override func tapped(){
        doNextStep()
    }
    
    // no need to change
    private func doNextStep(){
        if tutorialLayers.count > 0{
            previousLayer.removeFromSuperlayer()
            
            let layer = tutorialLayers.remove(at: 0)
            previousLayer = layer
            tutorialView.layer.addSublayer(layer)
            
            tutorialView.bringSubview(toFront: animationView)
            
            audio.playNextAudio()
            
            animationView.play{ (finished) in}
        }
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
    
    // Change based on what you want to highlight
    private func getFirstStepLayer(){
        
        let currGoalsFrame = vc.view.convert(vc.currentGoalsLabel.frame, from:vc.currentGoalView)
        
        let path = UIBezierPath(rect: goalVCFrame)
        
        // Change this
        let highlightPath = UIBezierPath(roundedRect: currGoalsFrame, cornerRadius: 5)
        //
        
        path.append(highlightPath)
        path.usesEvenOddFillRule = true
        
        let fillLayer = CAShapeLayer()
        
        fillLayer.path = path.cgPath
        fillLayer.fillRule = kCAFillRuleEvenOdd
        
        fillLayer.fillColor = UIColor.black.cgColor
        fillLayer.opacity = 0.8
        
        tutorialLayers.append(fillLayer)
    }
    
    private func getSecondStepLayer(){
        let  addNewGoalBtnFrame = vc.view.convert(vc.addNewGoalBtn.frame, from:vc.addNewGoalBtnUIView)
        
        let path = UIBezierPath(rect: goalVCFrame)
        
        // Change this
        let highlightPath = UIBezierPath(roundedRect: addNewGoalBtnFrame, cornerRadius: 5)
        //
        
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
