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
        
        if UserDefaults.standard.bool(forKey: "firstTime"){
            performSegue(withIdentifier: "StartToFirstTimeSegue", sender: self)
        }
        else{
            performSegue(withIdentifier: "StartToMainSegue", sender: self)
        }
    }
}

