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
    private var observers = [AudioObserver]()
    private var state: PlayerState = PlayerState.Pause
    private var currentTime:CMTime = CMTime(seconds: 0, preferredTimescale: 1)
    private var duration:CMTime!
    
    func getState() -> PlayerState{
        return state
    }
    
    func setState(state:PlayerState){
        self.state = state
        notifyObservers()
    }
    
    func getDuration()->Double{
        return duration.seconds
    }
    
    func getDuration()->CMTime{
        return duration
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
    
    func setCurrentTime(currentTime:CMTime){
        self.currentTime = currentTime
        notifyObservers()
    }
    
    func updateCurrentTime(sliderValue:Float){
        currentTime = CMTime(seconds: Double(sliderValue) * duration.seconds, preferredTimescale: 1)
        state = .Play
        notifyObservers()
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
        observer.setSubject(subject: self)
    }
    
    func notifyObservers(){
        for observer in observers{
            observer.updateNotification()
        }
    }
}

