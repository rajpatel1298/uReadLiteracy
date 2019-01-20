//
//  SocialMediaUserCell.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/15/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit

class SocialMediaUserCell: UITableViewCell {
    
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
