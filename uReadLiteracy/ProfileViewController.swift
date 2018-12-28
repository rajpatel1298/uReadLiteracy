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
    
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var numOfLoginLabel: UILabel!
    
    @IBOutlet weak var articlesReadLabel: UILabel!
    
    @IBOutlet weak var favoriteTopicLabel: UILabel!
    
    @IBOutlet weak var timeSpentLabel: UILabel!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var loadingView: UIView!
    
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
    
    var goals = [GoalModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        roundProfileIV()
        roundBackgroundProfileIV()
        animateBackgroundProfileIV()
        //roundInfoView()
        roundAddNewGoalBtn()
        loadUserInfo()
        
        setupTestGoals()
        
        setupDailyGoalsProgressCircle()
        setupUserProgressCircle()
    }
    
    @IBAction func addNewGoalBtnPressed(_ sender: Any) {
    }
    
    
    private func setupUserProgressCircle(){
        let center = CGPoint(x: view.frame.width - iconView.frame.midX, y: iconView.frame.midY)
        //userProgressCircle = GoalProgressCircle(percent: 99, center: center, width: iconView.frame.width*1.2, view: view)
    }
    
    private func setupDailyGoalsProgressCircle(){
        let center1 = CGPoint(x: goal1View.bounds.width - (goal1View.bounds.width/5)/2, y: goal1View.bounds.height/2)
        goal1ProgressCircle = GoalProgressCircle(percent: Int(goals[0].progress), center: center1, width: goal1View.bounds.width/5, view: goal1View)
        
        let center2 = CGPoint(x: goal2View.bounds.width - (goal2View.bounds.width/5)/2, y: goal2View.bounds.height/2)
        goal2ProgressCircle = GoalProgressCircle(percent: Int(goals[1].progress), center: center2, width: goal2View.bounds.width/5, view: goal2View)
        
        let center3 = CGPoint(x: goal3View.bounds.width - (goal3View.bounds.width/5)/2, y: goal3View.bounds.height/2)
        goal3ProgressCircle = GoalProgressCircle(percent: Int(goals[2].progress), center: center3, width: goal3View.bounds.width/5, view: goal3View)
    }
    
    private func resetDailyGoalsProgressCircleCenter(){
        let center1 = CGPoint(x: goal1View.bounds.width - (goal1View.bounds.width/5)/2, y: goal1View.bounds.height/2)
        goal1ProgressCircle.reset(center: center1)
        
        let center2 = CGPoint(x: goal2View.bounds.width - (goal2View.bounds.width/5)/2, y: goal2View.bounds.height/2)
        goal2ProgressCircle.reset(center: center2)
        
        let center3 = CGPoint(x: goal3View.bounds.width - (goal3View.bounds.width/5)/2, y: goal3View.bounds.height/2)
        goal3ProgressCircle.reset(center: center3)
    }
    
    private func setupTestGoals(){
        goals.append(GoalModel(name: "Test Goal 1: Test Goal", progress: 24, date: Date()))
        goals.append(GoalModel(name: "Test Goal 2: Test Goal Lalalallla", progress: 44, date: Date()))
        goals.append(GoalModel(name: "Test Goal 3: Test Goal Lalalallla", progress: 64, date: Date()))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let center = CGPoint(x: view.frame.width - iconView.frame.midX, y: iconView.frame.midY)
        
        //userProgressCircle.reset(center: center)
        resetDailyGoalsProgressCircleCenter()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        goal1.text = goals[0].getDescription()
        goal2.text = goals[1].getDescription()
        goal3.text = goals[2].getDescription()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //userProgressCircle.animate()
        goal1ProgressCircle.animate()
        goal2ProgressCircle.animate()
        goal3ProgressCircle.animate()
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
    
    
    
    private func roundInfoView(){
        infoView.layer.cornerRadius = 10
        infoView.layer.masksToBounds = false
        infoView.clipsToBounds = true
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
