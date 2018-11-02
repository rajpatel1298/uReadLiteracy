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
        showWalkthroughIfFirstTime()
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
    
    private func showWalkthroughIfFirstTime(){
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough"){
            return
        }
        
        let storyboard = UIStoryboard(name: "Tutorial", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkthroughViewController {
            present(walkthroughViewController, animated: true, completion: nil)
        }
    }

}

