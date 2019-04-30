//
//  LearnViewControllerTutorial.swift
//  uReadLiteracy
//
//  Created by Raj Patel on 2/12/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit
import Lottie

// For other Tutorial Controller, just copied the same code, and change stuffs when noted
class LearnViewControllerTutorial:TutorialController{
    private let vc: LearnViewController
    
    init(vc:LearnViewController){
        self.vc = vc
        
        // Change based on the audio that you will use
        super.init(audio: TutorialAudio(audioFiles: ["learnMoreTutorial1","learnMoreTutorial2"]), vc: vc)
        setHandAnimationColorBlack()
        //
    }
    
    
    // Change based on the number of steps
    override func show(onComplete:@escaping ()->Void){
        // Change This part
        //steps.append(firstStep)
        //steps.append(secondStep)
        //
        super.show(onComplete: onComplete)
    }
    
    // Change based on what you want to highlight
    /*private func firstStep(){
        //let currGoalsFrame = vc.view.convert(vc.tableview.frame, from:vc.view)
        let noWordsFrame = vc.tableview.frame
        showHighlightFrame(frame: noWordsFrame)
        setHandAnimationPosition(frame: noWordsFrame)
    }
    
    private func secondStep(){
        let noWordsFrame = vc.tableview.frame
        showHighlightFrame(frame: noWordsFrame)
        setHandAnimationPosition(frame: noWordsFrame)
    }*/
}
