//
//  GoalTableViewCell.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/23/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import Lottie

class GoalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var goalSubLabel: UILabel!
    @IBOutlet weak var goalFinishAnimationView: LOTAnimationView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        goalFinishAnimationView.animationSpeed = 0.8
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
