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
        
        vc.view.addSubview(controller.view)
        controller.view.frame = vc.view.frame
        animate()
    }
    
    func hide(vc:UIViewController){
        controller.removeFromParentViewController()
    }
    
    func animate(){
        controller.starView.play()
        AudioPlayer.sharedInstance.playSound(soundName: "goal_complete")
    }
    
}
