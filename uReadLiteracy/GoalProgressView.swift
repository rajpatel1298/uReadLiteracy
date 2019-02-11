//
//  GoalProgressView.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/11/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class GoalProgressView:UIView{
    private var circle:GoalProgressCircle!
    private var goalLabel:UILabel!
    
    private var percent = 0
    private var goalDescription = ""
    
    init(percent: Int, goalDescription:String){
        self.percent = percent
        self.goalDescription = goalDescription
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupGoalCircle()
        setupGoalLabel()
    }
    
    private func setupGoalLabel(){
        goalLabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.width*2/3, height: bounds.height))
        goalLabel.font = UIFont(name: "NokioSans-Bold", size: 20)
        goalLabel.text = goalDescription
        addSubview(goalLabel)
    }
    
    private func setupGoalCircle(){
        circle = GoalProgressCircle(percent: percent, frame: CGRect(x: bounds.width * 2 / 3, y: 0, width: bounds.width * 1 / 3, height: bounds.height))
        addSubview(circle)
        
    }
    
    func animate(){
        circle.animate()
    }
}
