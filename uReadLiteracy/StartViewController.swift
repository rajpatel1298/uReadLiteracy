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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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

