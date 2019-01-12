//
//  GoalViewControllerTutorial.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/10/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class GoalViewControllerTutorial:Tutorial{
    private var tutorialLayers = [CAShapeLayer]()
    
    private var previousLayer = CAShapeLayer()
    private let goalVCFrame:CGRect
    private let vc:GoalViewController
    private var rightArrow = CALayer()
    private var onComplete:()->Void = {}
    private var tutorialView = UIView(frame: .zero)
    private var gestureAdded = false
    private var audio = GoalViewControllerTutorialAudio()
    
    
    init(vc:GoalViewController){
        
        self.vc = vc
        tutorialView.isUserInteractionEnabled = true
        self.goalVCFrame = vc.view.frame
        super.init()
        setupRightArrow()
    }
    
    override func addGesture(gesture:UITapGestureRecognizer){
        tutorialView.addGestureRecognizer(gesture)
        gestureAdded = true
    }
    
    private func setupRightArrow(){
        let layerSize = vc.view.frame.width/5
        
        let myImage = #imageLiteral(resourceName: "rightArrow").cgImage
        rightArrow.frame = CGRect(x: vc.view.frame.width/2 - layerSize/2, y: vc.view.frame.height/2 - layerSize/2, width: layerSize, height: layerSize)
        rightArrow.contents = myImage
    }
    
    override func show(view:UIView,onComplete:@escaping ()->Void){
        if !gestureAdded{
            fatalError("need to use gestureAdded function")
        }
        
        self.onComplete = onComplete
        
        tutorialView.frame = vc.view.frame
        
        getFirstStepLayer(view: view)
        getSecondStepLayer(view: view)
        
        vc.view.addSubview(tutorialView)
        
        doNextStep()
    }
    
    override func tapped(){
        doNextStep()
    }
    
    private func doNextStep(){
        previousLayer.removeFromSuperlayer()
        rightArrow.removeFromSuperlayer()
        
        if tutorialLayers.count > 0{
            let layer = tutorialLayers.remove(at: 0)
            previousLayer = layer
            tutorialView.layer.addSublayer(layer)
            tutorialView.layer.addSublayer(rightArrow)
            
            audio.playNextAudio()
        }
        else{
            tutorialView.removeFromSuperview()
            onComplete()
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
