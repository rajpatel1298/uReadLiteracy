//
//  AudioPlayer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 10/28/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayer:AudioObserver{
    var subject: AudioSubject?
    private var timer:Timer!
    private let player:AVPlayer!
    
    private var isPlaying = false
    
    init(subject: AudioSubject, url:URL){
        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player.volume = 1.0
        self.subject = subject
        subject.setFullTime(fullTime: playerItem.asset.duration)
        
        player.automaticallyWaitsToMinimizeStalling = true
    
    }
    
    @objc func updateTimer() {
        subject!.notifyObservers(currentTime: player!.currentTime())
    }
    
    func update() {
        DispatchQueue.main.async {
            if(!self.isPlaying){
                self.player.seek(to: (self.subject?.getCurrentTime())!)
            }
        }
    }
    
    func play() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        DispatchQueue.main.async {
            self.player.play()
        }
        isPlaying = true
        
    }
    
    func pause() {
        player.pause()
        timer.invalidate()
        isPlaying = false
    }
}
