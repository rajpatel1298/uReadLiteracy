//
//  AllAchievementCollectionViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 5/27/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit

private let reuseIdentifier = "AllAchievementCollectionCell"

class AllAchievementCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    @IBOutlet var collectionview: UICollectionView!
    
    private var articleAchievements = [Achievement]()
    private var minutesAchievements = [Achievement]()
    private var categoryAchievements = [Achievement]()
    private let achievementManager = AchievementManager()
    
    private var cellIndexDictionary = [IndexPath:UICollectionViewCell]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        articleAchievements = achievementManager.getAllArticlesAchievements()
        categoryAchievements = achievementManager.getAllCategoryAchivements()
        minutesAchievements = achievementManager.getAllMinuteAchivements()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.height/6, height: view.frame.height/6)
    }
    

   
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return articleAchievements.count
        case 1:
            return minutesAchievements.count
        case 2:
            return categoryAchievements.count
        default:
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AchievementCollectionViewCell
        cellIndexDictionary[indexPath] = cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let cell = cell as! AchievementCollectionViewCell
        
        var achievement:Achievement!
        
        if(indexPath.section == 0){
            achievement = achievementManager.getAllArticlesAchievements()[indexPath.row]
        }
        if(indexPath.section == 1){
            achievement = achievementManager.getAllMinuteAchivements()[indexPath.row]
        }
        if(indexPath.section == 2){
            achievement = achievementManager.getAllCategoryAchivements()[indexPath.row]
        }
        
        cell.imageview.image = achievement.image
        cell.titleLabel.text = achievement.title
        cell.quoteLabel.text = achievement.quote ?? ""
        cell.inject(achievement: achievement, viewcontroller: self)
        cell.hideSocialMedia()
        
        if(!achievement.completed){
            cell.imageview.alpha = 0.3
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = cellIndexDictionary[indexPath] as! AchievementCollectionViewCell
        
        var achievement:Achievement!
        
        if(indexPath.section == 0){
            achievement = achievementManager.getAllArticlesAchievements()[indexPath.row]
        }
        if(indexPath.section == 1){
            achievement = achievementManager.getAllMinuteAchivements()[indexPath.row]
        }
        if(indexPath.section == 2){
            achievement = achievementManager.getAllCategoryAchivements()[indexPath.row]
        }
        
        if(achievement.completed){
            if(cell.facebookBtn.isHidden == false){
                cell.hideSocialMedia()
            }
            else{
                cell.showSocialMedia()
            }
            cell.facebookBtn.isHidden = false
        }
    }
    
    
    
    
    
}
