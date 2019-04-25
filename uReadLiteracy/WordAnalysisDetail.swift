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
    let urlRequests:[URLRequest]
    
    init(detail:String, urlRequests:[URLRequest]){
        self.detail = detail
        self.urlRequests = urlRequests
    }
}
