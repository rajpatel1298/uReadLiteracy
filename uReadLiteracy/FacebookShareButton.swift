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

class FacebookShareButton:LOTAnimationView,FBSDKSharingDelegate{
    private var content = FBSDKShareLinkContent()
    private let dialog = FBSDKShareDialog()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let facebookTap = UITapGestureRecognizer(target: self, action: #selector(facebookShareBtnPressed(_:)))
        addGestureRecognizer(facebookTap)
    }
    
    func inject(achievement:Achievement, viewcontroller:UIViewController){
        content.quote = SocialMediaQuote.get(achievement: achievement)
        dialog.fromViewController = viewcontroller
    }
    
    @objc func facebookShareBtnPressed(_ sender: UITapGestureRecognizer) {
        content.contentURL = URL(string: "https://www.google.com/")
        content.hashtag = FBSDKHashtag(string: "#Uread #FeelsGood")
        
        dialog.shareContent = content
        dialog.delegate = self
        dialog.mode = FBSDKShareDialogMode.web
        
        if !dialog.canShow {
            dialog.mode = FBSDKShareDialogMode.automatic
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
    
    func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!) {
        print()
    }
    
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
        print()
    }
    
    func sharerDidCancel(_ sharer: FBSDKSharing!) {
        print()
    }
}
