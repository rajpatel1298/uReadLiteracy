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
    
    @IBOutlet weak var nogoalIV: UIImageView!
    
    @IBOutlet weak var noGoalStackView: UIStackView!
    
    @IBOutlet weak var addNewGoalBarBtn: UIBarButtonItem!
    
    
    
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
        updateDailyGoalsList()
        updateOngoingGoalsList()
        
        tableview.reloadData()
        
        if(dailyGoals.count == 0 && ongoingGoals.count == 0){
            noGoalStackView.isHidden = false
            tableview.isHidden = true
            addNewGoalBarBtn.title = ""
            /*let alert = ChoosingGoalAlert(viewcontroller: self, title: "You Have No Reading Goals Currently", message: "Please Choose Your Goals", completionHandler: {
             self.performSegue(withIdentifier: "GoalToChoosingGoalSegue", sender: self)
             })
             alert.show()*/
        }
        else{
            noGoalStackView.isHidden = true
            tableview.isHidden = false
            addNewGoalBarBtn.title = "Add New Goal"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        /*let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = view.frame
        
        replicatorLayer.instanceCount = 360
        replicatorLayer.instanceDelay = CFTimeInterval(4 / 360.0)
        replicatorLayer.preservesDepth = false
        replicatorLayer.instanceColor = UIColor.red.cgColor
        
        replicatorLayer.instanceRedOffset = 0.0
        replicatorLayer.instanceGreenOffset = -0.5
        replicatorLayer.instanceBlueOffset = -0.5
        replicatorLayer.instanceAlphaOffset = 0.0
        
        let angle = Float(Double.pi * 2.0) / 360
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)
        
        
        
        let instanceLayer = CALayer()
        let layerWidth: CGFloat = 10
        let midX = view.frame.midX - layerWidth / 2.0
        instanceLayer.frame = CGRect(x: midX , y: view.frame.midY + 100, width: layerWidth, height: layerWidth)
        instanceLayer.backgroundColor = UIColor.blue.cgColor
        replicatorLayer.addSublayer(instanceLayer)
        
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 1.0
        fadeAnimation.toValue = 0.0
        fadeAnimation.duration = 4
        fadeAnimation.repeatCount = Float.greatestFiniteMagnitude
        
        instanceLayer.opacity = 0.0
        instanceLayer.add(fadeAnimation, forKey: "FadeAnimation")
        
        view.layer.addSublayer(replicatorLayer)*/
        
    }
    
    func updateDailyGoalsList(){
        dailyGoals = GoalManager.getDailyGoals()
    }
    func updateOngoingGoalsList(){
        ongoingGoals = GoalManager.getOngoingGoals()
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
