//
//  ArticleTableViewCell.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/25/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit
import Lottie
import AVKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var speakerView: LOTAnimationView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private let synthesizer = AVSpeechSynthesizer()
    private var utterance:AVSpeechUtterance!
    
    override func layoutSubviews() {
        setupSpeakerView()
    }
    
    private func setupSpeakerView(){
        speakerView.loopAnimation = true
        speakerView.autoReverseAnimation = true
        speakerView.play()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(speakerAction))
        speakerView.addGestureRecognizer(gesture)
        
        utterance = AVSpeechUtterance(string: titleLabel.text ?? "")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        utterance.rate = 0.2
    }
    
    @objc private func speakerAction(){
        synthesizer.speak(utterance)
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
