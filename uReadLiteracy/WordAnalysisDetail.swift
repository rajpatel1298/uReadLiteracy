//
//  WordAnalysisDetail.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/13/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

struct WordAnalysisDetail{
    let detail:String
    let videoHtmlList:[String]
    let title:String
    
    init(title:String,detail:String, videoHtmlList:[String]){
        self.detail = detail
        self.videoHtmlList = videoHtmlList
        self.title = title
    }
}
