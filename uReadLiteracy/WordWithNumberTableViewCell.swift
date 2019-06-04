//
//  WordWithNumberTableViewCell.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/17/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit
import Lottie
import AVKit

class WordWithNumberTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
        
    private var textToVoice = TextToVoiceService()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc func tapped(sender:UITapGestureRecognizer){
        playSoundUsingTitle()
    }
    
    private func playSoundUsingTitle(){
        textToVoice.setText(text: titleLabel.text ?? "")
        textToVoice.playFast()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sizeToFit()
        layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
