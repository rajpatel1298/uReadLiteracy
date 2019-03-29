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
    @IBOutlet weak var speakerAnimationView: LOTAnimationView!
    
    var definition:String!
    
    private let synthesizer = AVSpeechSynthesizer()
    private var utterance:AVSpeechUtterance!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSpeakerAnimationView()
    }
    
    private func setupSpeakerAnimationView(){
        speakerAnimationView.loopAnimation = true
        speakerAnimationView.autoReverseAnimation = true
        speakerAnimationView.play()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(speakerAction))
        speakerAnimationView.addGestureRecognizer(gesture)
        
        utterance = AVSpeechUtterance(string: definition)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        if(definition.split(separator: " ").count == 1){
            utterance.rate = 0.3
        }
        else{
            utterance.rate = 0.45
        }
    }
    
    @objc private func speakerAction(sender:UIView){
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
