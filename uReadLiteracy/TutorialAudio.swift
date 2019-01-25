//
//  TutorialAudio.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/12/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class TutorialAudio:AudioPlayer{
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
}
