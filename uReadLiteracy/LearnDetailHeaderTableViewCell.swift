//
//  LearnDetailHeaderTableViewCell.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/24/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit

class LearnDetailHeaderTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var dropdownIV: UIImageView!
    
    var expanded = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let radians =  CGFloat.pi
        let rotation = CGAffineTransform(rotationAngle: radians)
        dropdownIV.transform = rotation
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
