//
//  AudioTimeLabel.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 10/28/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class AudioTimeLabel:UILabel, AudioObserver{
    var subject: AudioSubject?
    
    init(){
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setSubject(subject:AudioSubject){
        self.subject = subject
    }
    
    
    func updateNotification() {
        let time:String = (subject?.getCurrentTime())!
        self.text = time
    }
    
    
    
    
}
