//
//  YoutubeURLRequestManager.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/17/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class YoutubeURLRequestManager{
    static let shared = YoutubeURLRequestManager()
    private var youtubeUrlRequests = [URLRequest]()
    
    func get(helpWord:HelpWordModel)->[URLRequest]{
        
        if(helpWord.isBeginningDifficult()){
            let url = URL(string: "https://www.youtube.com/watch?v=WGERKJYjkQI") //no beginning video yet
            let request = URLRequest(url: url!)
            youtubeUrlRequests.append(request)
        }
        if(helpWord.isEndingDifficult()){
            let url = URL(string: "https://www.youtube.com/watch?v=WGERKJYjkQI")
            let request = URLRequest(url: url!)
            youtubeUrlRequests.append(request)
        }
        if(helpWord.isBlendDifficult()){
            let url = URL(string: "https://www.youtube.com/watch?v=k-n_LHGseNk")
            let request = URLRequest(url: url!)
            youtubeUrlRequests.append(request)
        }
        if(helpWord.isMultisyllabicDifficult()){
            let url = URL(string: "https://www.youtube.com/watch?v=vNR2xyrZVv0")
            let request = URLRequest(url: url!)
            youtubeUrlRequests.append(request)
        }
        
        return youtubeUrlRequests
    }
}
