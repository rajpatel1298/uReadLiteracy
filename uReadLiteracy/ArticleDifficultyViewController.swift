//
//  ArticleDifficultyViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 6/4/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit

class ArticleDifficultyViewController: UIViewController {

    private var category:ArticleCategory = .Art
    private var difficulty:ReadingDifficulty = .Level1
    
    
    func inject(category:ArticleCategory){
        self.category = category
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func level1BtnPressed(_ sender: Any) {
        difficulty = ReadingDifficulty.Level1
        performSegue(withIdentifier: "ReadingDifficultyToArticleSelectSegue", sender: self)
    }
    
    @IBAction func level2BtnPressed(_ sender: Any) {
        difficulty = ReadingDifficulty.Level2
        performSegue(withIdentifier: "ReadingDifficultyToArticleSelectSegue", sender: self)
    }
    
    @IBAction func level3BtnPressed(_ sender: Any) {
        difficulty = ReadingDifficulty.Level3
        performSegue(withIdentifier: "ReadingDifficultyToArticleSelectSegue", sender: self)
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ArticleSelectViewController{
            destination.inject(category: category, difficulty: difficulty)
        }
    }

}
