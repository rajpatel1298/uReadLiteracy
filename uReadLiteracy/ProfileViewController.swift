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
    
    var circle:GoalProgressCircle!

    override func viewDidLoad() {
        super.viewDidLoad()
        roundProfileIV()
        roundBackgroundProfileIV()
        animateBackgroundProfileIV()
        //roundInfoView()
        loadUserInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let center = CGPoint(x: view.frame.width - iconView.frame.midX, y: iconView.frame.midY)
        
        if circle == nil{
            circle = GoalProgressCircle(percent: 99, center: center, width: iconView.frame.width*80/100, view: view)
        }
        else{
            circle.reset(center: center)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        circle.animate()
    }
    
    private func loadUserInfo(){
        let user = UserModel()
        profileIV.image = user.getImage()
        backgroundProfileIV.image = user.getImage()
        welcomeLabel.text = "Welcome \(user.getNickname())"
        
    }
    
    private func roundProfileIV(){
        profileIV.layer.cornerRadius = profileIV.frame.width/2
        profileIV.layer.masksToBounds = false
        profileIV.clipsToBounds = true
    }
    
    private func roundBackgroundProfileIV(){
        backgroundProfileIV.layer.cornerRadius = backgroundProfileIV.frame.width/2
        backgroundProfileIV.layer.masksToBounds = false
        backgroundProfileIV.clipsToBounds = true
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
