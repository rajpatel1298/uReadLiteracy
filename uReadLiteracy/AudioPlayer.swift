//
//  AudioPlayer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/23/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayer{
    private var player: AVAudioPlayer?
    static var shared = AudioPlayer()
    
    func playSound(soundName:String, audioExtension:String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: audioExtension) else {
            return
        }
        
      
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playSound(soundName:String, audioExtension:String, delegate:AVAudioPlayerDelegate) {
        playSound(soundName: soundName, audioExtension: audioExtension)
        player?.delegate = delegate
    }
}
