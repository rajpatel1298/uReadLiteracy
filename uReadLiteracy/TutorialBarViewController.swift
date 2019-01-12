//
//  TutorialBarViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/10/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit

class TutorialBarViewController: UIViewController {
    
    
    @IBOutlet weak var tutorialBtn: UIButton!
    
    static var currentController:UIViewController!
    private var tutorial:Tutorial!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tutorialBtnPressed(_ sender: Any) {
        
        switch(TutorialBarViewController.currentController){
        case is GoalViewController:
            let vc = TutorialBarViewController.currentController as! GoalViewController
            
            /*let shadowLayer = CALayer()
            shadowLayer.backgroundColor = UIColor.black.cgColor
            shadowLayer.frame = vc.view.frame
            shadowLayer.opacity = 0.5
            
            vc.view.layer.addSublayer(shadowLayer)*/
            
            tutorial = GoalViewControllerTutorial(vc: vc)
            let gesture = UITapGestureRecognizer(target: self, action: #selector(onTapped(_:)))
            tutorial.addGesture(gesture: gesture)
            
            tutorial.show(view: vc.view) {
                self.tutorialBtn.isEnabled = true
            }
            tutorialBtn.isEnabled = false
            
            /*let path = UIBezierPath(rect: vc.view.frame)
            let firstHighlight = UIBezierPath(rect: vc.goalOptionStackView.frame)
            path.append(firstHighlight)
            path.usesEvenOddFillRule = true
            
            let fillLayer = CAShapeLayer()
            
            fillLayer.path = path.cgPath
            fillLayer.fillRule = kCAFillRuleEvenOdd
            
            fillLayer.fillColor = UIColor.black.cgColor
            fillLayer.opacity = 0.8
            vc.view.layer.addSublayer(fillLayer)*/
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
