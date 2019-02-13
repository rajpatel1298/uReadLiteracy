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
    
    var goal:GoalType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "library (1)"))
        tableView.backgroundView?.alpha = 0.05
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if goal == GoalType.Daily{
            navigationItem.title = "Chose Daily Goal"
        }
        else{
            navigationItem.title = "Chose Going Goal"
        }
        getGoals()
    }
    
    func getGoals(){
        if goal == GoalType.Daily{
            dailyGoals = [GoalModel]()
            
            let read10Articles:ReadXArticlesCD? = CoreDataManager.shared.find(name: "Read 10 Articles", date: Date(), goalType: goal)
            
            if read10Articles == nil{
                let read10Articles = ReadXArticlesGoalModel(name: "Read 10 Articles", date: Date(), goalType: goal, numberOfArticles: 10)
                dailyGoals.append(read10Articles)
            }
            
            let readFor30Minutes:ReadXMinutesCD? = CoreDataManager.shared.find(name: "Read for 30 minutes", date: Date(), goalType: goal)
            
            if readFor30Minutes == nil{
                let readFor30Minutes = ReadXMinutesGoalModel(name: "Read for 30 minutes", date: Date(), goalType: goal, totalMinutes: 30)
                
                dailyGoals.append(readFor30Minutes)
            }
            
            let read1Articles = ReadXArticlesGoalModel(name: "Test: Read 1 Articles", date: Date(), goalType: goal, numberOfArticles: 1)
            dailyGoals.append(read1Articles)
        }
        
        if goal == GoalType.Ongoing{
            ongoingGoals = [GoalModel]()
            
            let read50Articles:ReadXArticlesCD? = CoreDataManager.shared.find(name: "Read 50 Articles", date: Date(), goalType: goal)
            
            if read50Articles == nil{
                let read50Articles = ReadXArticlesGoalModel(name: "Read 50 Articles", date: Date(), goalType: goal, numberOfArticles: 50)
                ongoingGoals.append(read50Articles)
            }
            
            let readFor120Minutes:ReadXMinutesCD? = CoreDataManager.shared.find(name: "Read for 2 hours", date: Date(), goalType: goal)
            
            if readFor120Minutes == nil{
                let readFor120Minutes = ReadXMinutesGoalModel(name: "Read for 2 hours", date: Date(), goalType: goal, totalMinutes: 120)
                
                ongoingGoals.append(readFor120Minutes)
            }
        }
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
        cell.backgroundColor = UIColor.clear

        switch(goal!){
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
                switch(self.goal!){
                case .Daily:
                    CoreDataGetter.shared.save(goalModel: self.dailyGoals[indexPath.row])
                    break
                case .Ongoing:
                    CoreDataGetter.shared.save(goalModel: self.ongoingGoals[indexPath.row])
                    break
                }
  
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
        var message = ""
        
        switch(goal!){
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
