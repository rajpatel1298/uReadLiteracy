//
//  CountingLabel.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 12/25/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class CountingLabel:UILabel{
    private var timer:Timer!
    private var currentValue:Float = 0
    private let maxValue:Float
    private var numberOfUpdates:Double = 100
    private var percent:Int!
    private let loadingDuration:Double
    
    init(percent:Int,loadingDuration:Double, frame:CGRect){
        self.maxValue = Float(percent)
        self.loadingDuration = loadingDuration
        self.percent = percent
        super.init(frame: frame)
        
    }
    
    func animate(){
        currentValue = Float(0)
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(loadingDuration)/numberOfUpdates, target: self, selector: #selector(CountingLabel.update), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc private func update(){
        if(currentValue<maxValue){
            self.text = "\(String(format: "%.0f", currentValue))"
            currentValue = currentValue + Float(percent)/100
        }
        else{
            timer.invalidate()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.maxValue = 0
        self.percent = 0
        self.loadingDuration = 1
        super.init(coder: aDecoder)
    }
}
