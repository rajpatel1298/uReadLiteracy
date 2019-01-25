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
class ProfileViewControllerTutorial:TutorialController{
    private let vc: ProfileViewController
    

    init(vc:ProfileViewController){
        self.vc = vc
        
        // Change based on the audio that you will use
        super.init(audio: TutorialAudio(audioFiles: ["profileTutorial1","goalTutorial2"]), vc: vc)
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
        let currGoalsFrame = vc.view.convert(vc.currentGoalsLabel.frame, from:vc.currentGoalView)
        highlightFrame(frame: currGoalsFrame)
    }
    
    private func getSecondStepLayer(){
        let  addNewGoalBtnFrame = vc.view.convert(vc.addNewGoalBtn.frame, from:vc.addNewGoalBtnUIView)
        highlightFrame(frame: addNewGoalBtnFrame)
    }
}
