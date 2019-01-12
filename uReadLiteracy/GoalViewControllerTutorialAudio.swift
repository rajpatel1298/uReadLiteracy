//
//  GoalViewControllerTutorialAudio.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/12/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class GoalViewControllerTutorialAudio:TutorialAudio{
    private var audioFiles = ["goalTutorial1","goalTutorial2"]
    private var currentCount = 0
    
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
