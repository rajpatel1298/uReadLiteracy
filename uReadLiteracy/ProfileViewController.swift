//
//  ProfileViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/1/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import UserNotifications

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var profileIV: RoundedImageView!
    @IBOutlet weak var backgroundProfileIV: ProfileBackgroundImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var iconView: UIView!
    
    @IBOutlet weak var currentGoalsLabel: UILabel!
    @IBOutlet weak var currentGoalView: UIView!
    @IBOutlet weak var addNewGoalBtn: RoundedButton!
    
    @IBOutlet weak var goalStackView: UIStackView!
   
    var currentGoals = [GoalModel]()


    override func viewDidLoad() {
        super.viewDidLoad()
  
        loadUserInfo()
        

        //set up daily notifications
        let content = UNMutableNotificationContent()
        content.title = "URead"
        content.body = "Remember to finish your daily goals on URead!"
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: "daily", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCurrentGoals()
        setupGoalStackView()
        backgroundProfileIV.animate()
    }
    
    private func setupGoalStackView(){
        for v in goalStackView.subviews{
            v.removeFromSuperview()
        }
        
        for goal in currentGoals{
            let goalView = GoalProgressView(percent: goal.progress, goalDescription: goal.getDescription())
            goalStackView.addArrangedSubview(goalView)
        }
        
        var count = currentGoals.count
        while count < 3{
            goalStackView.addArrangedSubview(UIView())
            count += 1
        }
    }
    
 
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for v in goalStackView.subviews{
            v.layoutSubviews()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for v in goalStackView.subviews{
            if let v = v as? GoalProgressView{
                v.animate()
            }
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
    
    
    
    private func loadUserInfo(){
        let user = CurrentUserModel()

        if user.getImage() == nil{
            profileIV.image = #imageLiteral(resourceName: "profile_hd")
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
