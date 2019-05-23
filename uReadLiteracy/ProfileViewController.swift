//
//  ProfileViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/1/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import UserNotifications

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var profileIV: RoundedImageView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
  
        loadUserInfo()

        //set up daily notifications
        let content = UNMutableNotificationContent()
        content.title = "URead"
        content.body = "Remember to finish your daily goals on URead!"
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: "daily", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        /*let temp = TextToVoiceService.init()
        temp.setText(text: "This word has a long vowel sound made by a single vowel in the middle or end of the word,.  A long vowel sound says the name of the letter of the vowel,. Sometimes this occurs when I, or O, is followed by two consonants (for example, kind, find, pint, Christ, climb, most, post, gold, sold, comb),.  The I, or the Y, at the end of a word will sound long and say the name either of the letter I, of the letter E,. If you’re not sure which it is, try it both ways and decide which makes sense and sounds like a real word")
        temp.playNormal()*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func loadUserInfo(){
        let user = CurrentUser.shared

        if user.getImage() == nil{
            profileIV.image = #imageLiteral(resourceName: "emptyProfile")
            profileIV.backgroundColor = UIColor.white
        }
        else{
            profileIV.image = user.getImage()
        }
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
