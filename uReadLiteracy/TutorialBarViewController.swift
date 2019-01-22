//
//  TutorialBarViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/10/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit


// This class
class TutorialBarViewController: UIViewController {
    
    
    @IBOutlet weak var tutorialBtn: UIButton!
    
    static var currentController:UIViewController!
    private var tutorial:Tutorial!
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func tutorialBtnPressed(_ sender: Any) {
        switch(TutorialBarViewController.currentController){
        case is GoalViewController:
            let vc = TutorialBarViewController.currentController as! GoalViewController
            
            tutorial = GoalViewControllerTutorial(vc: vc)
            let gesture = UITapGestureRecognizer(target: self, action: #selector(onTapped(_:)))
            tutorial.addGesture(gesture: gesture)
            
            tutorial.show() {
                self.tutorialBtn.isEnabled = true
            }
            tutorialBtn.isEnabled = false
            break
        case is ProfileViewController:
            let vc = TutorialBarViewController.currentController as! ProfileViewController
            
            tutorial = ProfileViewControllerTutorial(vc: vc)
            let gesture = UITapGestureRecognizer(target: self, action: #selector(onTapped(_:)))
            tutorial.addGesture(gesture: gesture)
            
            tutorial.show() {
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
