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

class GoalCompleteHelper{
    
    private let controller:GoalCompleteViewController
    static let shared = GoalCompleteHelper()
    
    init(){
        let storyboard = UIStoryboard.init(name: "Goal", bundle: Bundle.main)
        controller = storyboard.instantiateViewController(withIdentifier: "GoalCompleteViewController") as! GoalCompleteViewController
    }
    
    func show(goal:GoalModel){
        controller.goal = goal
        
        let window = UIApplication.shared.keyWindow!
        controller.view.frame = window.frame
        window.addSubview(controller.view);
        
        
        //vc.addChildViewController(controller)
        //controller.didMove(toParentViewController: controller)
        
        //controller.view.frame = vc.view.frame
        //vc.view.addSubview(self.controller.view)
        
        controller.view.alpha = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.controller.view.alpha = 1
        }) { (completed) in
            if completed{
                self.animate()
            }
        }
    }
    
    func animate(){
        controller.starView.play()
        AudioPlayer.shared.playSound(soundName: "goal_complete")
    }
    
}
