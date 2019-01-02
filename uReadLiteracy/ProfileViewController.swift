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
    var goalViews: [UIView]!
    var goalCircles = [GoalProgressCircle]()
    var goalLabels:[UILabel]!

    override func viewDidLoad() {
        super.viewDidLoad()
        goalViews = [goal1View,goal2View,goal3View]
        goalLabels = [goal1,goal2,goal3]
        
        roundProfileIV()
        roundBackgroundProfileIV()
        animateBackgroundProfileIV()
        //roundInfoView()
        roundAddNewGoalBtn()
        loadUserInfo()
    }

    
    private func setupDailyGoalsProgressCircle(){
        if currentGoals.count == 0{
            return
        }
        
        goalCircles.removeAll()
        
        let centers = getDailyGoalsCircleCenters()
        for x in 0...currentGoals.count-1{
            goalCircles.append(GoalProgressCircle(percent: Int(currentGoals[x].progress), center: centers[x], width: goalViews[x].bounds.width/5, view: goalViews[x]))
        }
    }
    
    private func getDailyGoalsCircleCenters()->[CGPoint]{
        let center1 = CGPoint(x: goal1View.bounds.width - (goal1View.bounds.width/5)/2, y: goal1View.bounds.height/2)
        let center2 = CGPoint(x: goal2View.bounds.width - (goal2View.bounds.width/5)/2, y: goal2View.bounds.height/2)
        let center3 = CGPoint(x: goal3View.bounds.width - (goal3View.bounds.width/5)/2, y: goal3View.bounds.height/2)
        return [center1,center2,center3]
    }
    
    private func resetDailyGoalsProgressCircleCenter(){
        if currentGoals.count == 0{
            return
        }
        
        let centers = getDailyGoalsCircleCenters()
        for x in 0...currentGoals.count-1{
            goalCircles[x].reset(center: centers[x])
        }
    }
    
    private func setGoalLabelTexts(){
        if currentGoals.count == 0{
            return
        }
        
        for x in 0...currentGoals.count-1{
            goalLabels[x].text = currentGoals[x].getDescription()
        }
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
    
    private func hideGoalsThatDoesNotExist(){
        for goal in goalViews{
            goal.isHidden = false
        }
        
        if currentGoals.count == 0{
            goal1.text = "There is no goal right now"
            goal2.text = ""
            goal3.text = ""
        }
        else if currentGoals.count == 1{
            for x in 1...2{
                goalLabels[x].text = ""
            }
        }
        else if currentGoals.count == 2{
            for x in 2...2{
                goalLabels[x].text = ""
            }
        }
    }
    
    private func animateGoalProgressCircles(){
        if currentGoals.count == 0{
            return
        }
        
        for x in 0...currentGoals.count-1{
            goalCircles[x].animate()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCurrentGoals()
        setupDailyGoalsProgressCircle()
        setGoalLabelTexts()
        hideGoalsThatDoesNotExist()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resetDailyGoalsProgressCircleCenter()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateGoalProgressCircles()
    }
    
    private func loadUserInfo(){
        let user = UserModel()
        profileIV.image = user.getImage()
        backgroundProfileIV.image = user.getImage()
        welcomeLabel.text = "Welcome \(user.getNickname())"
    }
    
    private func roundProfileIV(){
        profileIV.layer.cornerRadius = 10
        profileIV.layer.masksToBounds = false
        profileIV.clipsToBounds = true
    }
    
    private func roundBackgroundProfileIV(){
        backgroundProfileIV.layer.cornerRadius = 10
        backgroundProfileIV.layer.masksToBounds = false
        backgroundProfileIV.clipsToBounds = true
    }
    
    private func roundAddNewGoalBtn(){
        addNewGoalBtn.layer.cornerRadius = 10
        addNewGoalBtn.layer.masksToBounds = false
        addNewGoalBtn.clipsToBounds = true
    }
    
    private func animateBackgroundProfileIV(){
        
        DispatchQueue.main.async {
            self.backgroundProfileIV.alpha = 0.3
            
            UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse,.repeat], animations: {
                self.backgroundProfileIV.alpha = 0.1
            }, completion: nil)
        }
        
        
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
