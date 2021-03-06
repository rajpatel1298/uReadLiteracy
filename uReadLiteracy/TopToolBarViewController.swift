//
//  TutorialBarViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/10/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit
import Lottie
import AVFoundation

// This class
class TopToolBarViewController: UIViewController, AVAudioPlayerDelegate {
    
    
    @IBOutlet weak var tutorialBtn: UIButton!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var recordLOTView: LOTAnimationView!
    @IBOutlet weak var commentLOTView: LOTAnimationView!
    
    var onPreviousBtnPressed: (()->Void)!
    var onRecordBtnPressed: (()->Void)!
    var onCommentBtnPressed: (()->Void)!
    
    var recording = false
    
    
    static var currentController:UIViewController!{
        didSet{
            shared.hidePreviousCommentRecordBtn()
        }
    }
    
    static var shared:TopToolBarViewController!
    
    private var tutorial:TutorialController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TopToolBarViewController.shared = self
        recordLOTView.loopAnimation = true
        recordLOTView.animationSpeed = 0.5
        recordLOTView.play()
        
        commentLOTView.autoReverseAnimation = true
        commentLOTView.loopAnimation = true
        commentLOTView.play()
        
        let recordBtnGesture = UITapGestureRecognizer(target: self, action: #selector(recordBtnPressed))
        recordLOTView.addGestureRecognizer(recordBtnGesture)
        
        let commentBtnGesture = UITapGestureRecognizer(target: self, action: #selector(commentBtnPressed))
        commentLOTView.addGestureRecognizer(commentBtnGesture)
    }
    
    func showPreviousCommentRecordBtn(){
        recordLOTView.isHidden = false
        commentLOTView.isHidden = false
        previousBtn.isHidden = false
    }
    
    func hidePreviousCommentRecordBtn(){
        recordLOTView.isHidden = true
        commentLOTView.isHidden = true
        previousBtn.isHidden = true
    }
    
    @objc private func commentBtnPressed() {
        onCommentBtnPressed()
    }
    
    
    @objc private func recordBtnPressed() {
        if !recording{
            AudioPlayer.shared.playSound(soundName: "prerecording", audioExtension: "mp3", delegate: self)
        }
        else{
            onRecordBtnPressed()
            AudioPlayer.shared.playSound(soundName: "postrecording", audioExtension: "mp3", delegate: self)
            recordLOTView.animation = "notRecordingMicrophone"
            recordLOTView.loopAnimation = true
            recordLOTView.play()
        }
        
        recording = !recording
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag{
            if recording{
                onRecordBtnPressed()
                recordLOTView.animation = "recordingMicrophone"
                recordLOTView.loopAnimation = true
                recordLOTView.play()
            }
        }
    }
    
    @IBAction func previousBtnPressed(_ sender: Any) {
        if onPreviousBtnPressed != nil {
            onPreviousBtnPressed!()
        }
    }
    
    @IBAction func tutorialBtnPressed(_ sender: Any) {
        if tutorial != nil {
            tutorial.removeGesture()
        }
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onTapped(_:)))
        
        switch(TopToolBarViewController.currentController){
        case is GoalViewController:
            let vc = TopToolBarViewController.currentController as! GoalViewController
            
            tutorial = GoalViewControllerTutorial(vc: vc)
            tutorial.addGesture(gesture: gesture)
            
            tutorial.show() {
                self.tutorialBtn.isEnabled = true
            }
            tutorialBtn.isEnabled = false
            break
        case is ProfileViewController:
            let vc = TopToolBarViewController.currentController as! ProfileViewController
            
            tutorial = ProfileViewControllerTutorial(vc: vc)
            tutorial.addGesture(gesture: gesture)
            
            tutorial.show() {
                self.tutorialBtn.isEnabled = true
            }
            tutorialBtn.isEnabled = false
            break
        case is RecordViewController:
            let vc = TopToolBarViewController.currentController as! RecordViewController
            
            tutorial = RecordViewControllerTutorial(vc: vc)
            tutorial.addGesture(gesture: gesture)
        
            tutorial.show(){
                self.tutorialBtn.isEnabled = true
            }
            tutorialBtn.isEnabled = false
            break
        case is BrowserViewController:
            let vc = TopToolBarViewController.currentController as! BrowserViewController
            
            tutorial = BrowseViewControllerTutorial(vc: vc)
            tutorial.addGesture(gesture: gesture)
            
            tutorial.show(){
                self.tutorialBtn.isEnabled = true
            }
            tutorialBtn.isEnabled = false
            break
        case is LearnViewController:
            let vc = TopToolBarViewController.currentController as! LearnViewController
            
            tutorial = LearnViewControllerTutorial(vc: vc)
            tutorial.addGesture(gesture: gesture)
            
            tutorial.show(){
                self.tutorialBtn.isEnabled = true
            }
            tutorialBtn.isEnabled = false
            break
        case .none:
            break
        case .some(_):
            break
        }

    }
    
    @objc func onTapped(_ sender:UITapGestureRecognizer){
        tutorial.tapped()
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
