//
//  ChooseGoalTypeViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 12/29/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit

class ChooseGoalTypeViewController: UIViewController {

    var goalTypeSegue:GoalType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dailyGoalBtnPressed(_ sender: Any) {
        goalTypeSegue = GoalType.Daily
        performSegue(withIdentifier: "ChooseGoalTypeToChooseGoalSegue", sender: self)
    }
    
    @IBAction func ongoingGoalBtnPressed(_ sender: Any) {
        goalTypeSegue = GoalType.Ongoing
        performSegue(withIdentifier: "ChooseGoalTypeToChooseGoalSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ChooseGoalViewController{
            destination.goalType = goalTypeSegue
        }
    }
    

}
