//
//  FacebookShareButton.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 5/25/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import Lottie
import FBSDKShareKit
import FacebookShare

class FacebookShareButton:RoundedButton,SharingDelegate{
    func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
        print()
    }
    
    func sharer(_ sharer: Sharing, didFailWithError error: Error) {
        print()
    }
    
    func sharerDidCancel(_ sharer: Sharing) {
        print()
    }
    
    private var content = ShareLinkContent()
    private let dialog = ShareDialog()
    
    func inject(achievement:Achievement, viewcontroller:UIViewController){
        content.quote = SocialMediaQuote.get(achievement: achievement)
        dialog.fromViewController = viewcontroller
    }
    
    @objc func facebookShareBtnPressed(_ sender: UITapGestureRecognizer) {
        content.contentURL = URL(string: "https://www.google.com/")!
        content.hashtag = Hashtag("#Uread #FeelsGood")
        
        dialog.shareContent = content
        dialog.delegate = self
        dialog.mode = ShareDialog.Mode.web
        
        if !dialog.canShow {
            dialog.mode = ShareDialog.Mode.automatic
        }
        dialog.show()
        
        
        /*var content = LinkShareContent(url: URL(string: "https://www.google.com/")!)
         content.quote = SocialMediaQuote.get(goal: goal)
         content.hashtag = Hashtag("#Uread #FeelsGood")
         
         do {
         try ShareDialog.show(from: self, content: content)
         }
         catch{
         print(error)
         }*/
    }
    
   
}
