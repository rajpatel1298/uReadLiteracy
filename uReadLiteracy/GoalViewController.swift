//
//  GoalViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/23/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit

class GoalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dailyGoals: [GoalModel]!
    var ongoingGoals: [GoalModel]!
    
    var selectedGoal:GoalModel!
    
    // No Goal Stackview
    @IBOutlet weak var nogoalIV: UIImageView!
    @IBOutlet weak var noGoalStackView: UIStackView!
    @IBOutlet weak var addNewGoalBarBtn: UIBarButtonItem!
    
    
    @IBOutlet weak var addNewGoalBtn: UIButton!
    
    
    @IBOutlet weak var dailyTabButton: UIButton!
    @IBOutlet weak var ongoingTabButton: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    var selectedGoalType:GoalType = GoalType.Daily
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedGoalType == GoalType.Daily{
            return dailyGoals.count
        }
        else{
            return ongoingGoals.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "GoalTableViewCell") as! GoalTableViewCell
        if selectedGoalType == GoalType.Daily{
            let goal = dailyGoals[indexPath.row]
            cell.goalSubLabel.text = goal.getDescriptionWithProgress()
        }
        else{
            let goal = ongoingGoals[indexPath.row]
            cell.goalSubLabel.text = goal.getDescriptionWithProgress()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section) {
        case 0:
            selectedGoal = dailyGoals[indexPath.row]
            break
        case 1:
            break
        default:
            break
        }
        
        performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
    }*/
    
    
    @IBAction func dailyTabBtnPressed(_ sender: Any) {
        selectedGoalType = .Daily
        refreshTableView()
        refreshGoalTabUI()
    }
    
    @IBAction func ongoingTabBtnPressed(_ sender: Any) {
        selectedGoalType = .Ongoing
        refreshTableView()
        refreshGoalTabUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDailyGoalsList()
        updateOngoingGoalsList()
        
        tableview.reloadData()
        selectedGoalType = .Daily
        refreshGoalTabUI()
        refreshTableView()
        
    }
    
    func showNoGoalStackView(){
        noGoalStackView.isHidden = false
        tableview.isHidden = true
        addNewGoalBarBtn.title = ""
    }
    
    func hideNoGoalStackView(){
        noGoalStackView.isHidden = true
        tableview.isHidden = false
        addNewGoalBarBtn.title = "Add New Goal"
    }
    
    func refreshTableView(){
        tableview.reloadData()
        if selectedGoalType == GoalType.Daily{
            if dailyGoals.count == 0{
                showNoGoalStackView()
            }
            else{
                hideNoGoalStackView()
            }
        }
        else{
            if ongoingGoals.count == 0{
                showNoGoalStackView()
            }
            else{
                hideNoGoalStackView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyTabButton.layer.cornerRadius = 5
        dailyTabButton.clipsToBounds = true
        dailyTabButton.layer.masksToBounds = false
        
        ongoingTabButton.layer.cornerRadius = 5
        ongoingTabButton.clipsToBounds = true
        ongoingTabButton.layer.masksToBounds = false
        
        addNewGoalBtn.layer.cornerRadius = 5
        addNewGoalBtn.clipsToBounds = true
        addNewGoalBtn.layer.masksToBounds = false
    }
    
    func updateDailyGoalsList(){
        dailyGoals = GoalManager.getDailyGoals()
    }
    func updateOngoingGoalsList(){
        ongoingGoals = GoalManager.getOngoingGoals()
    }
    
    func refreshGoalTabUI(){
        var onBtn:UIButton!
        var offBtn:UIButton!
        
        if selectedGoalType == GoalType.Daily{
            onBtn = dailyTabButton
            offBtn = ongoingTabButton
        }
        else{
            offBtn = dailyTabButton
            onBtn = ongoingTabButton
        }
        
        let blue = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        
        offBtn.setTitleColor(blue, for: .normal)
        offBtn.setTitleColor(UIColor.white, for: .selected)
        offBtn.backgroundColor = UIColor.white
        offBtn.layer.borderColor = blue.cgColor
        offBtn.layer.borderWidth = 1
        
        onBtn.setTitleColor(UIColor.white, for: .normal)
        onBtn.setTitleColor(blue, for: .selected)
        onBtn.backgroundColor = blue
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ChooseGoalViewController{
            if(dailyGoals.count == 0){
                destination.goal = GoalType.Daily
            }
            else if(ongoingGoals.count == 0){
                destination.goal = GoalType.Ongoing
            }
        }
    }
    

}
