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

// For other Tutorial Controller, just copied the same code, and change stuffs when noted
class GoalViewControllerTutorial:TutorialController{
    private let vc:GoalViewController
    
    init(vc:GoalViewController){
        self.vc = vc
        
        // Change based on the audio that you will use
        super.init(audio: TutorialAudio(audioFiles: ["goalTutorial1","goalTutorial2"]), vc: vc)
        //
    }
    
    // Change based on the number of steps
    override func show(onComplete:@escaping ()->Void){
        // Change This part
        getFirstStepLayer()
        getSecondStepLayer()
        //
        
        super.show(onComplete: onComplete)
    }
    
    // Change based on what you want to highlight
    private func getFirstStepLayer(){
        let  goalOptionStackViewFrame = vc.goalOptionStackView.frame
        
        let path = UIBezierPath(rect: vc.view.frame)
        
        // Change this
        let highlightPath = UIBezierPath(roundedRect: goalOptionStackViewFrame, cornerRadius: 5)
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
        let  addNewGoalBtnFrame = vc.addNewGoalBtn.frame
        
        let path = UIBezierPath(rect: vc.view.frame)
        
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
