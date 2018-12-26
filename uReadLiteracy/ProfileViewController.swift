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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        roundProfileIV()
        roundBackgroundProfileIV()
        animateBackgroundProfileIV()
        //roundInfoView()
        loadUserInfo()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let center = CGPoint(x: view.frame.width - iconView.frame.midX, y: iconView.frame.midY)
        
        let percent = 99
        
        let loading = LoadingCircle(position: center,radius: iconView.frame.width/2 - 10, percent: percent)
        
        let pulsingLayer = CAShapeLayer()
        pulsingLayer.path = loading.path
        pulsingLayer.fillColor = UIColor.red.cgColor
        pulsingLayer.opacity = 0.5
        pulsingLayer.position = center
        
        view.layer.addSublayer(pulsingLayer)
        
        /*let trackPath = CAShapeLayer()
        trackPath.path = loading.path
        trackPath.strokeColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 1).cgColor
        trackPath.fillColor = UIColor.white.cgColor
        trackPath.lineCap = kCALineCapRound
        trackPath.lineWidth = 10
        trackPath.position = center
        view.layer.addSublayer(trackPath)*/
        
        let pulsingAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulsingAnimation.fromValue = 1.3
        pulsingAnimation.toValue = 1.4
        
        pulsingAnimation.duration = 1
    
        pulsingAnimation.autoreverses = true
        pulsingAnimation.repeatCount = .infinity
        
        pulsingLayer.add(pulsingAnimation, forKey: "pulsingAnimation")
        
        
        view.layer.addSublayer(loading)
        loading.animate()
        
        
        
        //loading.addColorAnimation()
        
        let percentLabel = UILabel(frame: .zero)
        
        percentLabel.frame = CGRect(x: center.x - iconView.frame.width/8, y: iconView.frame.minY, width: iconView.frame.width, height: iconView.frame.height)
        
        percentLabel.text = "\(percent)%"
        view.addSubview(percentLabel)
        
        /*UIView.animate(withDuration: 1, animations: {
            loading.strokeColor = UIColor.init(red: 255, green: 153, blue: 0, alpha: 1).cgColor
            
        }) { (_) in
            
            if(percent > 35){
                UIView.animate(withDuration: 1, animations: {
                    loading.strokeColor = UIColor.init(red: 255, green: 204, blue: 0, alpha: 1).cgColor
                }, completion: { (_) in
                    if(percent > 75){
                        UIView.animate(withDuration: 1, animations: {
                            loading.strokeColor = UIColor.init(red: 102, green: 255, blue: 51, alpha: 1).cgColor
                        })
                    }
                })
            }
        }*/
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
