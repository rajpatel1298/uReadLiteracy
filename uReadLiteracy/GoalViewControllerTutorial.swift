//
//  GoalViewControllerTutorial.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/10/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class GoalViewControllerTutorial:Tutorial{
    private var tutorialLayers = [CAShapeLayer]()
    
    private var previousLayer = CAShapeLayer()
    private let goalVCFrame:CGRect
    private let vc:GoalViewController
    private var onComplete:()->Void = {}
    private var tutorialView = UIView(frame: .zero)
    private var gestureAdded = false
    private var audio = GoalViewControllerTutorialAudio()
    private let animationView = LOTAnimationView(name: "hand_click_gesture")
    
    
    init(vc:GoalViewController){
        self.vc = vc
        tutorialView.isUserInteractionEnabled = true
        tutorialView.addSubview(animationView)
        
        self.goalVCFrame = vc.view.frame
        super.init()
        setupRightArrow()
    }
    
    override func addGesture(gesture:UITapGestureRecognizer){
        tutorialView.addGestureRecognizer(gesture)
        gestureAdded = true
    }
    
    override func show(view:UIView,onComplete:@escaping ()->Void){
        if !gestureAdded{
            fatalError("need to use gestureAdded function")
        }
        
        self.onComplete = onComplete
        
        tutorialView.frame = vc.view.frame
        
        let handSize = vc.view.frame.width/5
        animationView.frame = CGRect(x: vc.view.frame.width/2 - handSize/2, y: vc.view.frame.height/2 - handSize/2, width: handSize, height: handSize)
        
        getFirstStepLayer(view: view)
        getSecondStepLayer(view: view)
        
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
    
    private func getFirstStepLayer(view:UIView){
        let  goalOptionStackViewFrame = vc.goalOptionStackView.frame
        
        let path = UIBezierPath(rect: goalVCFrame)
        let highlightPath = UIBezierPath(roundedRect: goalOptionStackViewFrame, cornerRadius: 5)
        

        path.append(highlightPath)
        path.usesEvenOddFillRule = true
        
        let fillLayer = CAShapeLayer()
        
        fillLayer.path = path.cgPath
        fillLayer.fillRule = kCAFillRuleEvenOdd
        
        fillLayer.fillColor = UIColor.black.cgColor
        fillLayer.opacity = 0.8
        
        tutorialLayers.append(fillLayer)
    }
    
    private func getSecondStepLayer(view:UIView){
        let  addNewGoalBtnFrame = vc.addNewGoalBtn.frame
        
        let path = UIBezierPath(rect: goalVCFrame)
        let highlightPath = UIBezierPath(roundedRect: addNewGoalBtnFrame, cornerRadius: 5)
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
