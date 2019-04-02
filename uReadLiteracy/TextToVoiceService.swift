//
//  TextToVoiceService.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/1/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import AVKit

class TextToVoiceService{
    private let synthesizer = AVSpeechSynthesizer()
    private var utterance:AVSpeechUtterance!
    
    init(text:String){
        utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    }
    
    init(){
        utterance = AVSpeechUtterance(string: "")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    }
    
    func setText(text:String){
        utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    }
    
    func playSlow(){
        utterance.rate = 0.3
        synthesizer.speak(utterance)
    }
    func playNormal(){
        utterance.rate = 0.45
        synthesizer.speak(utterance)
    }
}
