//
//  ChooseGoalViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/24/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit

class ChooseGoalViewController: UITableViewController {

    var dailyGoals = ["Read 10 Articles","Read for 30 minutes"]
    var ongoingGoals = ["Read 50 Articles", "Read for 2 hours"]
    
    var goal:GoalType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(goal!){
        case .Daily:
            return dailyGoals.count
        case .Ongoing:
            return ongoingGoals.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseGoalCell", for: indexPath) as! ChooseGoalCell

        switch(goal!){
        case .Daily:
            cell.nameLabel.text = dailyGoals[indexPath.row]
        case .Ongoing:
            cell.nameLabel.text = ongoingGoals[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = ChoosingGoalAlert(viewcontroller: self) {
            DispatchQueue.main.async {
                switch(self.goal!){
                case .Daily:
                    let model = DailyGoalModel(name: "\(self.dailyGoals[indexPath.row])", date: Date(),type:DailyGoalType.ReadXMinutes)
                    model.save()
                    break
                case .Ongoing:
                    break
                }
            }
        }
        
        var message = "You choose "
        
        switch(goal!){
        case .Daily:
            alert.setTitle(title: "Daily Goal Confirm")
            message.append("\(dailyGoals[indexPath.row]) ?")
        case .Ongoing:
            alert.setTitle(title: "Ongoing Goal Confirm")
            message.append("\(ongoingGoals[indexPath.row]) ?")
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
