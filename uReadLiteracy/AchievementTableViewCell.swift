//
//  AchievementTableViewCell.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 5/25/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit
import Lottie

class AchievementTableViewCell: UITableViewCell {

    @IBOutlet weak var facebookBtn: FacebookShareButton!
    
    @IBOutlet weak var twitterBtn: TwitterShareButton!
    
    
    @IBOutlet weak var imageview: RoundedImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    
    private var achievement = Achievement(title: "", quote: nil, image: UIImage(), completed: false)
    private var mainVC:UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
         if mainVC != nil{
            facebookBtn.inject(achievement: achievement, viewcontroller: mainVC!)
         }
         
         twitterBtn.inject(achievement: achievement)
    }
    
    
    func inject(achievement:Achievement,mainVC:UIViewController){
        self.achievement = achievement
        self.mainVC = mainVC
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
