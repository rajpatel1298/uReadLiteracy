//
//  BrowseViewControllerTutorial.swift
//  uReadLiteracy
//
//  Created by Raj Patel on 2/11/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit
import Lottie

// For other Tutorial Controller, just copied the same code, and change stuffs when noted
class BrowseViewControllerTutorial:TutorialController{
    private let vc: BrowserViewController
    
    
    init(vc:BrowserViewController){
        self.vc = vc
        
        // Change based on the audio that you will use
        super.init(audio: TutorialAudio(audioFiles: ["browseTutorial1","browseTutorial2", "browseTutorial3", "browseTutorial4"]), vc: vc)
        setHandAnimationColorBlack()
        //
    }
    
    
    // Change based on the number of steps
    override func show(onComplete:@escaping ()->Void){
        // Change This part
        steps.append(firstStep)
        steps.append(secondStep)
        steps.append(thirdStep)
        steps.append(fourthStep)
        //
        super.show(onComplete: onComplete)
    }
    
    // Change based on what you want to highlight
    private func firstStep(){
        //let currGoalsFrame = vc.view.convert(vc.tableview.frame, from:vc.view)
        let webFrame = vc.webView.frame
        showHighlightFrame(frame: webFrame)
        setHandAnimationPosition(frame: webFrame)
    }
    
    private func secondStep(){
        //   let  addNewGoalBtnFrame = vc.view.convert(vc.addNewGoalBtn.frame, from:vc.addNewGoalBtnUIView)
        let webFrame = vc.webView.frame
        showHighlightFrame(frame: webFrame)
        setHandAnimationPosition(frame: webFrame)
    }
    
    private func thirdStep(){
        setHandAnimationColorWhite()
        let recordFrame = TopToolBarViewController.shared.recordBtn.frame
        showHighlightFrame(frame: recordFrame)
        setHandAnimationPosition(frame: recordFrame)
        
    }
    
    private func fourthStep(){
        let previousFrame = TopToolBarViewController.shared.previousBtn.frame
        showHighlightFrame(frame: previousFrame)
        setHandAnimationPosition(frame: previousFrame)
    }
}
