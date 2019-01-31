//
//  PlayButton.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/30/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class PlayButton:UIButton,AudioObserver{
    func setSubject(subject: AudioSubject) {
        self.subject = subject
    }
    
    var subject: AudioSubject?
    
    func updateNotification() {
        if subject?.getState() == .Pause{
            self.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
        else{
            self.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
