//
//  NoResultViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/5/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit
import Lottie

class NoResultViewController: UIViewController {
    
    @IBOutlet weak var animationView: AnimationView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var actionBtn: UIButton!
    
    private var titleStr = "No result"
    private var actionStr = "Give me more result"
    private var action:()->Void = {}
    
    func inject(title:String,actionStr:String, action:@escaping ()->Void){
        self.titleStr = title
        self.actionStr = actionStr
        self.action = action
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleStr
        actionBtn.setTitle(actionStr, for: .normal)
        animationView.loopMode = .loop
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animationView.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animationView.stop()
    }
    
    @IBAction func actionBtnPressed(_ sender: Any) {
        action()
    }
}
