//
//  NoWordToLearnViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/5/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit
import Lottie

class NoWordToLearnViewController: UIViewController {
    
    @IBOutlet weak var animationView: LOTAnimationView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goToBrowserBtnPressed(_ sender: Any) {
        tabBarController?.selectedIndex = 2
    }
}
