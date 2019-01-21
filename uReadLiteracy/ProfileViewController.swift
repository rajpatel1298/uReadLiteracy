//
//  ProfileViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/1/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileIV: UIImageView!
    @IBOutlet weak var backgroundProfileIV: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var iconView: UIView!
    
    
    @IBOutlet weak var goal1: UILabel!
    @IBOutlet weak var goal2: UILabel!
    @IBOutlet weak var goal3: UILabel!
    
    @IBOutlet weak var goal1View: UIView!
    @IBOutlet weak var goal2View: UIView!
    @IBOutlet weak var goal3View: UIView!
    
    
    
    @IBOutlet weak var addNewGoalBtn: UIButton!
    
    
    //var userProgressCircle:GoalProgressCircle!
    var goal1ProgressCircle:GoalProgressCircle!
    var goal2ProgressCircle:GoalProgressCircle!
    var goal3ProgressCircle:GoalProgressCircle!
    
    var currentGoals = [GoalModel]()
    var uiController:ProfileUIController!

    override func viewDidLoad() {
        super.viewDidLoad()
        uiController = ProfileUIController(vc: self)
        loadUserInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCurrentGoals()
        uiController.setupDailyGoalsProgressCircle()
        uiController.setGoalLabelTexts()
        uiController.hideGoalsThatDoesNotExist()
        uiController.resetDailyGoalsProgressCircleCenter()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        uiController.resetDailyGoalsProgressCircleCenter()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        uiController.animateGoalProgressCircles()
    }
    
    private func setupCurrentGoals(){
        currentGoals.removeAll()
        
        let dailyGoals = GoalManager.shared.getDailyGoals()
        let ongoingGoals = GoalManager.shared.getOngoingGoals()
        
        var count = 0
        for goal in dailyGoals{
            currentGoals.append(goal)
            count += 1
            
            if count == 3{
                return
            }
        }
        
        for goal in ongoingGoals{
            currentGoals.append(goal)
            count += 1
            
            if count == 3{
                return
            }
        }
    }
    
    
    
    private func loadUserInfo(){
        let user = UserModel.sharedInstance
        if user.getImage() == nil{
            profileIV.image = #imageLiteral(resourceName: "profile")
            backgroundProfileIV.image = nil
        }
        else{
            profileIV.image = user.getImage()
            backgroundProfileIV.image = user.getImage()
        }
        
        
        welcomeLabel.text = "Welcome \(user.getNickname())"
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
