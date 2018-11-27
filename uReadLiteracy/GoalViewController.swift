//
//  GoalViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/23/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit

class GoalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dailyGoals = [DailyGoalModel]()
    var ongoingGoals = ["LOL"]
    
    var selectedGoal:GoalModel!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return dailyGoals.count
        case 1:
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "GoalTableViewCell") as! GoalTableViewCell
        if(indexPath.section == 0){
            let goal = dailyGoals[indexPath.row]
            cell.goalSubLabel.text = goal.getDescription()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "GoalHeaderCell") as! GoalHeaderCell
        
        switch (section) {
        case 0:
            headerCell.nameLabel.text = "Daily Goals"
            break
        case 1:
            headerCell.nameLabel.text = "Ongoing Goals"
            break
        default:
            headerCell.nameLabel.text = "Other"
            break
        }
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
    
    
    
    @IBOutlet weak var tableview: UITableView!
    
    private var goals = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDailyGoals()
        tableview.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(dailyGoals.count == 0){
            let alert = ChoosingGoalAlert(viewcontroller: self, title: "You Have No Reading Goals Currently", message: "Please Choose Your Goals", completionHandler: {
                self.performSegue(withIdentifier: "GoalToChoosingGoalSegue", sender: self)
            })
            alert.show()
        }
        
    }
    
    func getDailyGoals(){
        dailyGoals = DailyGoalModel.getModels()
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
