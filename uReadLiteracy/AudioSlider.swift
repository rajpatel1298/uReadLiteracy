//
//  AudioSlider.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 10/29/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class AudioSlider:UISlider,AudioObserver{
    var subject: AudioSubject?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setSubject(subject: AudioSubject){
        self.subject = subject
    }
    
    func update() {
        let duration:Double = (subject?.getDuration())!
        let current:Double = (subject?.getCurrentTime())!
        let ratio = current/duration
        
        self.setValue(Float(ratio), animated: true)
    }
    
    
}
