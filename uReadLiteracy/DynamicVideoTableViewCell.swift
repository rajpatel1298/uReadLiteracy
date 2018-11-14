//
//  DynamicVideoTableViewCell.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/13/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import WebKit

class DynamicVideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var webview: WKWebView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
