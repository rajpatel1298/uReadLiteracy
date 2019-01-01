//
//  Goal.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/24/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation

class GoalModel{
    let name:String
    var progress:Int!
    let date:Date
    
    init(name:String,date:Date){
        self.name = name
        self.date = date
        progress = 0
    }
    
    init(name:String,progress:Int,date:Date){
        self.name = name
        self.progress = progress
        self.date = date
    }
    
    func getDescription()->String{
        return  "\(name)"
    }
    
    func getDescriptionWithProgress()->String{
        return  "\(name): \(Int(progress))%"
    }
    
    func save(){
        if let model = self as? ReadXMinutesGoalModel{
            model.save()
        }
        else if let model = self as? ReadXArticlesGoalModel{
            model.save()
        }
    }
    
    func isCompleted()->Bool{
        return progress == 100
    }
}
