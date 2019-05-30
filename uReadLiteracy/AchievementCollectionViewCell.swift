//
//  AchievementCollectionViewCell.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 5/26/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit

class AchievementCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageview: RoundedImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var facebookBtn: FacebookShareButton!
    @IBOutlet weak var twitterBtn: TwitterShareButton!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func showSocialMedia(){
        facebookBtn.isHidden = false
        twitterBtn.isHidden = false
        
        facebookBtn.alpha = 0
        twitterBtn.alpha = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.imageview.alpha = 0.3
            self.facebookBtn.alpha = 1
            self.twitterBtn.alpha = 1
        }, completion: { (completed) in
            if(completed){
                
            }
        })
        
    }
    
    func hideSocialMedia(){
        facebookBtn.alpha = 1
        twitterBtn.alpha = 1
        
        UIView.animate(withDuration: 0.5, animations: {
            self.facebookBtn.alpha = 0
            self.twitterBtn.alpha = 0
            self.imageview.alpha = 1
        }, completion: { (completed) in
            if(completed){
                self.facebookBtn.isHidden = true
                self.twitterBtn.isHidden = true
            }
        })
        
    }
    
    func inject(achievement:Achievement, viewcontroller:UIViewController){
        facebookBtn.inject(achievement: achievement, viewcontroller: viewcontroller)
        twitterBtn.inject(achievement: achievement)
    }
    
    
}
