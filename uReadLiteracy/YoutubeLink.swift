//
//  YoutubeLink.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 5/5/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class YoutubeLink{
    private var url:String
    
    init(url:String){
        self.url = url.replacingOccurrences(of: "https://www.youtube.com/watch?v=", with: "https://www.youtube.com/embed/")
    }
    
    func getHtml()->String{
        return "<iframe width=\"100%\" height=\"100%\" src=\"\(url)\" frameborder=\"0\" allowfullscreen></iframe>"
    }
}
