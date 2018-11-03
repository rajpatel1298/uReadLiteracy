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
    
    private let playerItem: AVPlayerItem
    
    init(url:URL){
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player.volume = 1.0
        
        player.automaticallyWaitsToMinimizeStalling = true
    }
    
    func setSubject(subject: AudioSubject) {
        self.subject = subject
        subject.setFullTime(fullTime: playerItem.asset.duration)
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
        if(timer != nil){
            timer.invalidate()
        }
        
        isPlaying = false
    }
}
