//
//  GoalCompleteViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/23/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit
import Lottie
import FBSDKShareKit
import FacebookShare

class GoalCompleteViewController: UIViewController,FBSDKSharingDelegate {
    
    @IBOutlet weak var twitterView: LOTAnimationView!
    @IBOutlet weak var facebookView: LOTAnimationView!
    @IBOutlet weak var nextView: LOTAnimationView!
    
    
    @IBOutlet weak var starView: LOTAnimationView!
    
    @IBOutlet weak var optionView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var goalDetailLabel: UILabel!
    
    
    
    
    var goal:GoalModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        starView.loopAnimation = true
        starView.backgroundColor = UIColor.clear
        
        let facebookTap = UITapGestureRecognizer(target: self, action: #selector(facebookShareBtnPressed(_:)))
        facebookView.addGestureRecognizer(facebookTap)
        
        let twitterTap = UITapGestureRecognizer(target: self, action: #selector(twitterShareBtnPressed(_:)))
        twitterView.addGestureRecognizer(twitterTap)
        
        let nextTap = UITapGestureRecognizer(target: self, action: #selector(nextShareBtnPressed(_:)))
        nextView.addGestureRecognizer(nextTap)
        
        facebookView.contentMode = .scaleAspectFit
        twitterView.contentMode = .scaleAspectFit
        nextView.contentMode = .scaleAspectFit
        
        contentView.layer.cornerRadius = 10.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        goalDetailLabel.text = "You Have Completed \"\(goal.getDescription())\""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        facebookView.play()
        twitterView.play()
        nextView.play()
    }

    
    @objc func facebookShareBtnPressed(_ sender: UITapGestureRecognizer) {
        /*let content = FBSDKShareLinkContent()
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
        dialog.show()*/
        
        let content = LinkShareContent(url: URL(string: "https://www.google.com/")!)
        
        do {
            try ShareDialog.show(from: self, content: content)
        }
        catch{
            
        }
    }
    
    @objc func twitterShareBtnPressed(_ sender: UITapGestureRecognizer) {
        let tweetText = SocialMediaQuote.get(goal: goal)
        let tweetUrl = "https://www.google.com/"
        
        let shareString = "https://twitter.com/intent/tweet?text=\(tweetText)&url=\(tweetUrl)"
        
        let escapedShareString = shareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url = URL(string: escapedShareString)
        
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    @objc func nextShareBtnPressed(_ sender: UITapGestureRecognizer) {
        self.removeFromParentViewController()
        view.alpha = 1
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.alpha = 0
        }) { (completed) in
            if completed{
                self.view.removeFromSuperview()
            }
        }
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
