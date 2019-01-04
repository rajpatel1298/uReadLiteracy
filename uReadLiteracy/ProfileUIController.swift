//
//  ProfileUIController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/2/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class ProfileUIController{
    fileprivate var goalViews: [UIView]!
    private var goalLabels:[UILabel]!
    fileprivate var goalCircles = [GoalProgressCircle]()
    
    var vc:ProfileViewController!
    
    init(vc:ProfileViewController){
        self.vc = vc
        
        goalViews = [vc.goal1View,vc.goal2View,vc.goal3View]
        goalLabels = [vc.goal1,vc.goal2,vc.goal3]
        
        roundProfileIV()
        roundBackgroundProfileIV()
        animateBackgroundProfileIV()
        roundAddNewGoalBtn()
    }
    
    
    
    func setGoalLabelTexts(){
        if vc.currentGoals.count == 0{
            return
        }
        
        for x in 0...vc.currentGoals.count-1{
            goalLabels[x].text = vc.currentGoals[x].getDescription()
        }
    }
    
    func hideGoalsThatDoesNotExist(){
        for goal in goalViews{
            goal.isHidden = false
        }
        
        if vc.currentGoals.count == 0{
            vc.goal1.text = "There is no goal right now"
            vc.goal2.text = ""
            vc.goal3.text = ""
        }
        else if vc.currentGoals.count == 1{
            for x in 1...2{
                goalLabels[x].text = ""
            }
        }
        else if vc.currentGoals.count == 2{
            for x in 2...2{
                goalLabels[x].text = ""
            }
        }
    }
    
    
    
    private func roundProfileIV(){
        vc.profileIV.layer.cornerRadius = 10
        vc.profileIV.layer.masksToBounds = false
        vc.profileIV.clipsToBounds = true
    }
    
    private func roundBackgroundProfileIV(){
        vc.backgroundProfileIV.layer.cornerRadius = 10
        vc.backgroundProfileIV.layer.masksToBounds = false
        vc.backgroundProfileIV.clipsToBounds = true
    }
    
    private func roundAddNewGoalBtn(){
        vc.addNewGoalBtn.layer.cornerRadius = 10
        vc.addNewGoalBtn.layer.masksToBounds = false
        vc.addNewGoalBtn.clipsToBounds = true
    }
    
    private func animateBackgroundProfileIV(){
        DispatchQueue.main.async {
            self.vc.backgroundProfileIV.alpha = 0.3
            
            UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse,.repeat], animations: {
                self.vc.backgroundProfileIV.alpha = 0.1
            }, completion: nil)
        }
    }
}

// MARK: Progress Circle
extension ProfileUIController{
    func setupDailyGoalsProgressCircle(){
        if vc.currentGoals.count == 0{
            return
        }
        
        goalCircles.removeAll()
        
        let centers = getDailyGoalsCircleCenters()
        for x in 0...vc.currentGoals.count-1{
            goalCircles.append(GoalProgressCircle(percent: Int(vc.currentGoals[x].progress), center: centers[x], width: goalViews[x].bounds.width/5, view: goalViews[x]))
        }
    }
    
    func getDailyGoalsCircleCenters()->[CGPoint]{
        let center1 = CGPoint(x: vc.goal1View.bounds.width - (vc.goal1View.bounds.width/5)/2, y: vc.goal1View.bounds.height/2)
        let center2 = CGPoint(x: vc.goal2View.bounds.width - (vc.goal2View.bounds.width/5)/2, y: vc.goal2View.bounds.height/2)
        let center3 = CGPoint(x: vc.goal3View.bounds.width - (vc.goal3View.bounds.width/5)/2, y: vc.goal3View.bounds.height/2)
        return [center1,center2,center3]
    }
    
    func resetDailyGoalsProgressCircleCenter(){
        if vc.currentGoals.count == 0{
            return
        }
        
        let centers = getDailyGoalsCircleCenters()
        for x in 0...vc.currentGoals.count-1{
            goalCircles[x].reset(center: centers[x])
        }
    }
    
    func animateGoalProgressCircles(){
        if vc.currentGoals.count == 0{
            return
        }
        
        for x in 0...vc.currentGoals.count-1{
            goalCircles[x].animate()
        }
    }
}
