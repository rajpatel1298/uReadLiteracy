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
    
    @IBOutlet weak var recordBtn: UIButton!
    
    var onPreviousBtnPressed: (()->Void)!
    var onRecordBtnPressed: (()->Void)!
    
    var recording = false
    
    
    static var currentController:UIViewController!{
        didSet{
            if currentController is ReadViewController{
                shared.previousBtn.isHidden = false
                shared.recordLOTView.isHidden = false
            }
            else{
                shared.previousBtn.isHidden = true
                shared.recordLOTView.isHidden = true
            }
        }
    }
    
    static var shared:TopToolBarViewController!
    
    private var tutorial:TutorialController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TopToolBarViewController.shared = self
        recordLOTView.loopAnimation = true
        recordLOTView.animationSpeed = 0.5
    }
    
    private func enablePreviousBtn(){
        previousBtn.alpha = 1
        previousBtn.isEnabled = true
    }
    private func disablePreviousBtn(){
        //previousBtn.alpha = 0.2
        previousBtn.isEnabled = false
    }
    
    private func enableRecordBtn(){
        recordLOTView.alpha = 1
        recordLOTView.play()
        recordBtn.isEnabled = true
    }
    
    private func disableRecordBtn(){
        //recordLOTView.alpha = 0.2
        recordLOTView.stop()
        recordBtn.isEnabled = false
    }
    
    func disablePreviousAndRecordBtn(){
        disableRecordBtn()
        disablePreviousBtn()
    }
    
    func enablePreviousAndRecordBtn(){
        enableRecordBtn()
        enablePreviousBtn()
    }
    
    
    @IBAction func recordBtnPressed(_ sender: Any) {
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
        case is ReadViewController:
            let vc = TopToolBarViewController.currentController as! ReadViewController
            
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
