//
//  AchievementCompleteViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/23/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit
import Lottie
import FBSDKShareKit
import FacebookShare


// This class should not be created. Create Goal Complete through GoalCompletePresenter
class AchievementCompleteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var achievements = [Achievement(title: "?", quote: "?", image: #imageLiteral(resourceName: "read100article"), completed: true)]
    
    
  
    func inject(achievements:[Achievement]){
        self.achievements = achievements
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.separatorColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        remove()
        view.removeFromSuperview()
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return achievements.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AchievementWithQuoteTableViewCell") as! AchievementTableViewCell
        cell.facebookView.contentMode = .scaleAspectFit
        cell.twitterView.contentMode = .scaleAspectFit
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! AchievementTableViewCell
        cell.imageview.image = achievements[indexPath.section].image
        cell.titleLabel.text = achievements[indexPath.section].title
        cell.quoteLabel.text = achievements[indexPath.section].quote ?? ""
        //cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.inject(achievement: achievements[indexPath.section], mainVC: self)
        
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 1) {
            cell.transform = CGAffineTransform.identity
        }
    }
    

}
