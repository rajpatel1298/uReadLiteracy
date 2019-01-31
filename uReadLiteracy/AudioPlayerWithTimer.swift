//
//  AudioPlayer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 10/28/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayerWithTimer:AudioObserver{
    
    
    var subject: AudioSubject?
    private var timer:Timer!
    private var player:AVPlayer!
    
    private var isPlaying = false
    
    init(){
        player = AVPlayer(playerItem: nil)
        player.automaticallyWaitsToMinimizeStalling = true
    }
    
    func playFile(url:URL){
        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        subject!.setFullTime(fullTime: playerItem.asset.duration)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        subject?.setState(state: .Play)
        
    }
    
    @objc private func playerDidFinishPlaying(note: NSNotification) {
        subject?.setCurrentTime(currentTime: (subject?.getDuration())!)
        subject?.setState(state: .Pause)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func updateTimer() {
        if subject?.getState() == .Play{
            subject?.setCurrentTime(currentTime: player!.currentTime())
        }
    }
    
    func updateNotification() {
        if subject?.getState() == .Play{
            play()
        }
        else{
            pause()
        }
    }
    
    func setSubject(subject: AudioSubject) {
        self.subject = subject
    }
    
    func moveTo(time:CMTime){
        player.seek(to: (self.subject?.getCurrentTime())!)
    }
    
    private func play() {
        DispatchQueue.main.async {
            if (self.timer != nil){
                self.timer.invalidate()
            }
            
            self.updateTimer()
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
            self.player.play()
            
            self.isPlaying = true
        }
        
    }
    
    func pause() {
        DispatchQueue.main.async {
            self.player.pause()
            if (self.timer != nil){
                self.timer.invalidate()
            }
            
            self.isPlaying = false
        }
    }
}
