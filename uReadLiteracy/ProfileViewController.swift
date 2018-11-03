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
    
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var numOfLoginLabel: UILabel!
    
    @IBOutlet weak var articlesReadLabel: UILabel!
    
    @IBOutlet weak var favoriteTopicLabel: UILabel!
    
    @IBOutlet weak var timeSpentLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        roundProfileIV()
        roundInfoView()
    }
    
    func roundProfileIV(){
        profileIV.layer.cornerRadius = profileIV.frame.width/2
        profileIV.layer.masksToBounds = false
        profileIV.clipsToBounds = true
    }
    
    func roundInfoView(){
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
