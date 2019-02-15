//
//  ChooseGoalViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/24/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit

class ChooseGoalViewController: UITableViewController {

    var dailyGoals = [GoalModel]()
    var ongoingGoals = [GoalModel]()
    
    var goalType:GoalType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "library (1)"))
        tableView.backgroundView?.alpha = 0.05
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if goalType == GoalType.Daily{
            navigationItem.title = "Chose Daily Goal"
        }
        else{
            navigationItem.title = "Chose Going Goal"
        }
        getGoals()
    }
    
    func getGoals(){
        if goalType == GoalType.Daily{
            dailyGoals = DailyGoalsGetter.shared.getOnlyNewGoals()
        }
        
        if goalType == GoalType.Ongoing{
            ongoingGoals = OngoingGoalGetter.shared.getOnlyNewGoals()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(goalType!){
        case .Daily:
            return dailyGoals.count
        case .Ongoing:
            return ongoingGoals.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseGoalCell", for: indexPath) as! ChooseGoalCell
        cell.backgroundColor = UIColor.clear

        switch(goalType!){
        case .Daily:
            cell.nameLabel.text = dailyGoals[indexPath.row].getDescription()
        case .Ongoing:
            cell.nameLabel.text = ongoingGoals[indexPath.row].getDescription()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = ChoosingGoalAlert(viewcontroller: self) {
            DispatchQueue.main.async {
                switch(self.goalType!){
                case .Daily:
                    CoreDataSaver.shared.save(goalModel: self.dailyGoals[indexPath.row])
                    break
                case .Ongoing:
                    CoreDataSaver.shared.save(goalModel: self.ongoingGoals[indexPath.row])
                    break
                }
  
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
        var message = ""
        
        switch(goalType!){
        case .Daily:
            alert.setTitle(title: "Daily Goal Confirm")
            message.append("\(dailyGoals[indexPath.row].getDescription()) has been added to your goal list!")
        case .Ongoing:
            alert.setTitle(title: "Ongoing Goal Confirm")
            message.append("\(ongoingGoals[indexPath.row].getDescription()) has been added to your goal list!")
        }
        
        alert.setMessage(message: message)
        alert.show()
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
