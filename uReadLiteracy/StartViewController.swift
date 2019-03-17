//
//  ViewController.swift
//  uReadLiteracy
//
//  Created by Raj Patel on 10/25/17.
//  Copyright © 2017 AdaptConsulting. All rights reserved.
//

import UIKit
import FacebookShare
import Lottie
import AVKit


class StartViewController: UIViewController {
    
    
    @IBOutlet weak var bookAnimationView: LOTAnimationView!
    
    @IBOutlet weak var continueLabel: UILabel! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookAnimationView.loopAnimation = true
        
        let string = "term, a word or phrase used to describe a thing or to express a concept, especially in a particular kind of language or branch of study."
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateContinueBtn()
        bookAnimationView.play()
    }
    
    private func animateContinueBtn(){
        UIView.animate(withDuration: 0.7, delay: 0, options: [.autoreverse,.repeat], animations: {
            self.continueLabel.alpha = 0.5
        }, completion: nil)
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough"){
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarViewController")
            self.show(vc, sender: self)
        }
        else{
            performSegue(withIdentifier: "StartToFirstTimeSegue", sender: self)
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarViewController")
        self.show(vc, sender: self)
    }

}

