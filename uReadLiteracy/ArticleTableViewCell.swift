//
//  ArticleTableViewCell.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/25/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit
import Lottie

class ArticleTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var slowSpeakerView: UIButton!
    
    @IBOutlet weak var fastSpeakerView: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var textToVoice = TextToVoiceService()
    
    override func layoutSubviews() {
        textToVoice.setText(text: titleLabel.text ?? "")
        
    }
    
    @IBAction func slowBtnPressed(_ sender: Any) {
        textToVoice.playSlow()
    }
    
    @IBAction func fastBtnPressed(_ sender: Any) {
        textToVoice.playFast()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
