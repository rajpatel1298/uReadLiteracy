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
    
    fileprivate let achievementManager = AchievementManager()
    fileprivate var cellIndexDictionary = [IndexPath:UICollectionViewCell]()
    
    @IBOutlet weak var achievementCollectionView: UICollectionView!
    @IBOutlet weak var profileIV: RoundedImageView!
    
    @IBOutlet weak var completedAchievementLabel: UILabel!
    
    @IBOutlet weak var articleReadLabel: UILabel!
    
    @IBOutlet weak var minutesReadingLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    
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
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: "daily", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        achievementCollectionView.reloadData()
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        completedAchievementLabel.text = "\(achievementManager.numberOfCompletedAchievement())"
        let articles:[ArticleCD] = CoreDataGetter.shared.getList()
        articleReadLabel.text = "\(articles.count)"
        var count = 0
        for article in articles{
            count = count + Int(article.minutesRead)
        }
        minutesReadingLabel.text = "\(count)"
        
        nameLabel.text = CoreDataGetter.shared.getMainUser()?.nickname ?? "Welcome"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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

}

extension ProfileViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return achievementManager.getAllCurrentAchievements().count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AchievementCollectionViewCell", for: indexPath) as! AchievementCollectionViewCell
        cellIndexDictionary[indexPath] = cell
        
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
        let cell = cellIndexDictionary[indexPath] as! AchievementCollectionViewCell
        
        // cell to view all achievements
        if(indexPath.row == achievementManager.getAllCurrentAchievements().count){
            performSegue(withIdentifier: "AchievementToAllAchievementSegue", sender: self)
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
        return CGSize(width: view.frame.height/5, height: view.frame.height/4)
    }
    
}
