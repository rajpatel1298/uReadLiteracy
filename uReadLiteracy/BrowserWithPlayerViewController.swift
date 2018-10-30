//
//  BrowserWithPlayerViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 10/28/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import SwiftSoup

class BrowserWithPlayerViewController: UIViewController {
    
    @IBOutlet weak var playPauseBtn: UIButton!
    
    @IBOutlet weak var audioSlider: AudioSlider!
    
    @IBOutlet weak var audioLabel: AudioTimeLabel!
    
    @IBOutlet weak var textview: UITextView!
    
    @IBOutlet weak var audioView: UIView!
    
    
    
    var childWebPage:ChildWebPage!
    var audioPlayer:AudioPlayer!
    
    //Observer Patern
    let subject = AudioSubject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textview.attributedText = nil
        textview.attributedText = childWebPage.getAttributedTextFromURL()
        
        let mp3Link = getMp3LinkIfExist()
        if(mp3Link == nil){
            return
        }
        
        let url = URL(string: mp3Link!)
        audioPlayer = AudioPlayer(subject: subject, url: url!)
        
        audioLabel.setSubject(subject: subject)
        audioSlider.setSubject(subject: subject)
        
        subject.attach(observer: audioLabel)
        subject.attach(observer: audioSlider)
        
        subject.attach(observer: audioPlayer)
        
        subject.setState(state: .Pause)
        
        audioSlider.isContinuous = false
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        audioPlayer.pause()
        subject.updateCurrentTime(sliderValue: audioSlider.value)
        DispatchQueue.main.async {
            self.playPauseBtn.setImage(#imageLiteral(resourceName: "pause.png"), for: .normal)
            self.audioPlayer.play()
            self.subject.setState(state: .Play)
        }
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        audioPlayer.pause()
    }
    
    @IBAction func playPauseBtnPressed(_ sender: Any) {
        switch(subject.getState()){
        case .Play:
            audioPlayer.pause()
            playPauseBtn.setImage(#imageLiteral(resourceName: "play.png"), for: .normal)
            subject.setState(state: .Pause)
            break
        case .Pause:
            playPauseBtn.setImage(#imageLiteral(resourceName: "pause.png"), for: .normal)
            audioPlayer.play()
            subject.setState(state: .Play)
            break
        }
    }
    
    
    private func getMp3LinkIfExist()->String?{
        let str = childWebPage.getHtmlString()
        
        if(str == nil){
            return nil
        }
        
        do {
            let doc: Document = try SwiftSoup.parse(str!)
            for link in try doc.select("a[href^=http]"){
  
                for l in try link.getAttributes()!{
                    if(l.getKey() == "href"){
                        if(try l.getValue().suffix(4).lowercased() == ".mp3"){
                            return l.getValue()
                        }
                    }
                }
                
                
            }
        } catch let error {
            print("Error: \(error)")
        }
        
        return nil
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
