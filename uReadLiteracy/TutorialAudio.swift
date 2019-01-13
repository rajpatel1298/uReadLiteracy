//
//  TutorialAudio.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/12/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import AVFoundation

class TutorialAudio{
    private var player: AVAudioPlayer?
    private var audioFiles: [String]!
    private var currentCount = 0
    
    init(audioFiles:[String]){
        self.audioFiles = audioFiles
    }
    
    func playNextAudio(){
        if currentCount > audioFiles.count-1 {
            fatalError("Out of range")
        }
        
        let name = audioFiles[currentCount]
        currentCount += 1
        
        playSound(soundName: name)
    }
    
    func reset(){
        currentCount = 0
    }
    
    private func playSound(soundName:String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
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
}
