//
//  TwitterShareButton.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 5/25/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class TwitterShareButton:LOTAnimationView{
    private var tweetText = ""
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let twitterTap = UITapGestureRecognizer(target: self, action: #selector(twitterShareBtnPressed(_:)))
        addGestureRecognizer(twitterTap)
    }
    
    @objc func twitterShareBtnPressed(_ sender: UITapGestureRecognizer) {
        let tweetUrl = "https://www.google.com/"
        
        let shareString = "https://twitter.com/intent/tweet?text=\(tweetText)&url=\(tweetUrl)"
        
        let escapedShareString = shareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url = URL(string: escapedShareString)
        
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    func inject(achievement:Achievement){
        tweetText = SocialMediaQuote.get(achievement: achievement)
    }
}
