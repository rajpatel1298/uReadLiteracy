//
//  RecordViewControllerTutorial.swift
//  uReadLiteracy
//
//  Created by Raj Patel on 1/26/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit
import Lottie

// For other Tutorial Controller, just copied the same code, and change stuffs when noted
class RecordViewControllerTutorial:TutorialController{
    private let vc: RecordViewController
    
    
    init(vc:RecordViewController){
        self.vc = vc
        
        // Change based on the audio that you will use
        super.init(audio: TutorialAudio(audioFiles: ["recordTutorial1","recordTutorial2"]), vc: vc)
        setHandAnimationColorBlack()
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
        //let currGoalsFrame = vc.view.convert(vc.tableview.frame, from:vc.view)
        let currGoalsFrame = vc.tableview.frame
        showHighlightFrame(frame: currGoalsFrame)
        setHandAnimationPosition(frame: currGoalsFrame)
    }
    
    private func secondStep(){
     //   let  addNewGoalBtnFrame = vc.view.convert(vc.addNewGoalBtn.frame, from:vc.addNewGoalBtnUIView)
        let recordListFrame = vc.tableview.frame
        showHighlightFrame(frame: recordListFrame)
        setHandAnimationPosition(frame: recordListFrame)
    }
}
