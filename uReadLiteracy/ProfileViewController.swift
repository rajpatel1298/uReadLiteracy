//
//  ProfileViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/1/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import UserNotifications

class ProfileViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    let achievementManager = AchievementManager()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return achievementManager.getAllCurrentAchievements().count + 1
    }
    
    var dic = [IndexPath:UICollectionViewCell]()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AchievementCollectionViewCell", for: indexPath) as! AchievementCollectionViewCell
        dic[indexPath] = cell

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! AchievementCollectionViewCell
        
        // cell to view all achievements
        if(indexPath.row == achievementManager.getAllCurrentAchievements().count){
            cell.imageview.image = UIImage(named: "more")
            cell.titleLabel.text = "See All Achievements"
            cell.quoteLabel.text = ""
            cell.hideSocialMedia()
        }
        else{
            let achievement = achievementManager.getAllCurrentAchievements()[indexPath.row]
            
            cell.imageview.image = achievement.image
            cell.titleLabel.text = achievement.title
            cell.quoteLabel.text = achievement.quote ?? ""
            cell.inject(achievement: achievement, viewcontroller: self)
            cell.hideSocialMedia()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = dic[indexPath] as! AchievementCollectionViewCell
        
        // cell to view all achievements
        if(indexPath.row == achievementManager.getAllCurrentAchievements().count){
            print()
        }
        else{
            if(cell.facebookBtn.isHidden == false){
                cell.hideSocialMedia()
            }
            else{
                cell.showSocialMedia()
            }
            cell.facebookBtn.isHidden = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.height/4, height: view.frame.height/4)
    }
    
    
    
    @IBOutlet weak var achievementCollectionView: UICollectionView!
    
    @IBOutlet weak var profileIV: RoundedImageView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        achievementCollectionView.collectionViewLayout = layout
        
        
    
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
        achievementCollectionView.reloadData()
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
