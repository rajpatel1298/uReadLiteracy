//
//  ViewController.swift
//  uReadLiteracy
//
//  Created by Raj Patel on 10/25/17.
//  Copyright © 2017 AdaptConsulting. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var continueLabel: UILabel! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateContinueBtn()
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

