//
//  DateExtension.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/19/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

extension Date{
    func toStringWithoutSpace()->String{
        let df = DateFormatter()
        df.dateFormat = "yyyyMMddhhmmss"
        let string = df.string(from: self)
        return string
    }
    
    func toString()->String{
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy, hh:mm:ss"
        let string = df.string(from: self)
        return string
    }
    
    static func get(string:String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddhhmmss"
        let date = dateFormatter.date(from:string)!
        return date
    }
}
