//
//  Subject.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 10/28/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import AVFoundation

class AudioSubject{
    enum PlayerState{
        case Play
        case Pause
    }
    
    private var observers = [AudioObserver]()
    private var state: PlayerState = PlayerState.Pause
    private var currentTime:CMTime!
    private var duration:CMTime!
    
    func getState() -> PlayerState{
        return state
    }
    
    func setState(state:PlayerState){
        self.state = state
    }
    
    func getDuration()->Double{
        return duration.seconds
    }
    
    func getCurrentTime()->String{
        return getTime(time: currentTime)
    }
    
    func getCurrentTime()->Double{
        return currentTime.seconds
    }
    
    func getCurrentTime()->CMTime{
        return currentTime
    }
    
    func updateCurrentTime(sliderValue:Float){
        currentTime = CMTime(seconds: Double(sliderValue) * duration.seconds, preferredTimescale: 1)
        notifyObservers(currentTime: currentTime)
    }
    
    func setFullTime(fullTime:CMTime){
        self.duration = fullTime
    }
    
    private func getTime(time: CMTime) -> String {
        let time = Int(time.seconds)
        
        let seconds = time%60
        let minutes = (time / 60)
        
        if(minutes < 9){
            return String(format: "%d:%02d", minutes, seconds)
        }
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func attach(observer:AudioObserver){
        observers.append(observer)
    }
    
    func notifyObservers(currentTime:CMTime){
        self.currentTime = currentTime
        for observer in observers{
            observer.update()
        }
    }
}

