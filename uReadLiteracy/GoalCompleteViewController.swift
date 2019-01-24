//
//  GoalCompleteViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/23/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit
import Lottie
import FacebookCore
import FacebookShare
import FBSDKShareKit

class GoalCompleteViewController: UIViewController,FBSDKSharingDelegate {
    func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!) {
        print()
    }
    
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
        print()
    }
    
    func sharerDidCancel(_ sharer: FBSDKSharing!) {
        print()
    }
    
    
    @IBOutlet weak var starView: LOTAnimationView!
    @IBOutlet weak var optionStackView: UIStackView!
    @IBOutlet weak var share: UIView!
    
    var goal:GoalModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        starView.loopAnimation = true
        starView.backgroundColor = UIColor.clear
        
        //addFacebookShareBtn()
    }
    
    private func addFacebookShareBtn(){
        let shareButton = ShareButton<LinkShareContent>()
        
 
        //SocialMediaQuote.get(goal: goal)
        
        //shareButton.content = content
        //shareButton.frame = starView.frame
        optionStackView.addArrangedSubview(shareButton)
    }
    
    @IBAction func facebookShareBtnPressed(_ sender: Any) {
        let content = FBSDKShareLinkContent()
        content.contentURL = URL(string: "https://www.google.com/")
        content.hashtag = FBSDKHashtag(string: "#Uread #FeelsGood")
        content.quote = SocialMediaQuote.get(goal: goal)
        
        let dialog = FBSDKShareDialog()
        dialog.fromViewController = self
        
        dialog.shareContent = content
        dialog.delegate = self
        dialog.mode = FBSDKShareDialogMode.web
        if !dialog.canShow {
            dialog.mode = FBSDKShareDialogMode.automatic
        }
        dialog.show()
    }
    
    
    @IBAction func continueBtnPressed(_ sender: Any) {
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
