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
        steps.append(firstStep)
        steps.append(secondStep)
        //
        super.show(onComplete: onComplete)
    }
    
    // Change based on what you want to highlight
    private func firstStep(){
        let  goalOptionStackViewFrame = vc.goalOptionStackView.frame
        showHighlightFrame(frame: goalOptionStackViewFrame)
        setHandAnimationPosition(frame: goalOptionStackViewFrame)
    }
    
    private func secondStep(){
        let  addNewGoalBtnFrame = vc.addNewGoalBtn.frame
        showHighlightFrame(frame: addNewGoalBtnFrame)
        setHandAnimationPosition(frame: addNewGoalBtnFrame)
    }
}
