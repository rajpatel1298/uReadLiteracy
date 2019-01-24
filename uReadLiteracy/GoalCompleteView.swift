//
//  AchivementView.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/21/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class GoalComplete{
    
    private let controller:GoalCompleteViewController
    static let shared = GoalComplete()
    
    init(){
        let storyboard = UIStoryboard.init(name: "Goal", bundle: Bundle.main)
        controller = storyboard.instantiateViewController(withIdentifier: "GoalCompleteViewController") as! GoalCompleteViewController
    }
    
    func show(vc:UIViewController, goal:GoalModel){
        controller.goal = goal
        
        vc.addChildViewController(controller)
        controller.didMove(toParentViewController: controller)
        
        controller.view.frame = vc.view.frame
        vc.view.addSubview(self.controller.view)
        
        vc.view.alpha = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            vc.view.alpha = 1
        }) { (completed) in
            if completed{
                self.animate()
            }
        }
    }
    
    func animate(){
        controller.starView.play()
        AudioPlayer.sharedInstance.playSound(soundName: "goal_complete")
    }
    
}
