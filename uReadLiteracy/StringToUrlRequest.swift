//
//  StringToUrlService.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/13/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class StringToUrlRequest{
    static func get(url:String)->URLRequest{
        let url = URL(string: url)
        let request = URLRequest(url: url!)
        return request
    }
}
