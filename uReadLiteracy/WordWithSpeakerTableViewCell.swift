//
//  WordWithSpeakerTableViewCell.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/17/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit
import Lottie
import AVKit

class WordWithSpeakerTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var definition:String!
    
    var textToVoice = TextToVoiceService()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSpeakerAnimationView()
    }
    
    private func setupSpeakerAnimationView(){
        textToVoice.setText(text: definition)
    }
    
    @IBAction func slowSpeakerBtnPressed(_ sender: Any) {
        textToVoice.playSlow()
    }
    
    @IBAction func fastSpeakerBtnPressed(_ sender: Any) {
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
