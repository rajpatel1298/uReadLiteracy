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

class AchievementCompletePresenter{
    
    private let controller:AchievementCompleteViewController
    static let shared = AchievementCompletePresenter()
    
    private var queue = [Achievement]()
    
    init(){
        let storyboard = UIStoryboard.init(name: "Goal", bundle: Bundle.main)
        controller = storyboard.instantiateViewController(withIdentifier: "AchievementCompleteViewController") as! AchievementCompleteViewController
    }
    
    func show(achievements:[Achievement]){
        if(achievements.count > 0){
            
            let window = UIApplication.shared.keyWindow!
            controller.view.frame = window.frame
            window.addSubview(controller.view)
            window.bringSubviewToFront(controller.view)
            
            controller.inject(achievements: achievements)
            
            controller.view.alpha = 0
            
            UIView.animate(withDuration: 0.5, animations: {
                self.controller.view.alpha = 1
            }) { (completed) in
                if completed{
                    self.animate()
                }
            }
        }
    }
    
    private func animate(){
        AudioPlayer.shared.playSound(soundName: "goal_complete", audioExtension: "mp3")
    }
    
}
