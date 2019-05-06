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
    private var synthesizer = AVSpeechSynthesizer()
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
        utterance.rate = 0.2
        play()
    }
    
    func playNormal(){
        utterance.rate = 0.35
        play()
    }
    
    func playFast(){
        utterance.rate = 0.4
        play()
    }
    
    private func play(){
        synthesizer.stopSpeaking(at: .immediate)
        synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
