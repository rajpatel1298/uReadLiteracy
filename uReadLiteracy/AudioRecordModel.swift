//
//  AudioRecordModel.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/27/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import CoreData

class AudioRecordModel{
    var path:String!
    var title:String!
    var date:Date!
    
    init(path:String,title:String,date:Date){
        self.path = path
        self.title = title
        self.date = date
    }
    
    func getTitle()->String{
        return title
    }
    
    func getDate()->Date{
        return date
    }
    
    func getPath()->String{
        return path
    }
    
    
    
    
    
    
}
