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
    var progress:Double!
    let date:Date
    
    init(name:String,date:Date){
        self.name = name
        self.date = date
        progress = 0
    }
    
    init(name:String,progress:Double,date:Date){
        self.name = name
        self.progress = progress
        self.date = date
    }
    
    func getDescription()->String{
        return  "\(name)"
        //return  "\(name): \(Int(progress))%"
    } 
}
