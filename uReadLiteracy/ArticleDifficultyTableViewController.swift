//
//  ArticleDifficultyTableViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/28/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit

class ArticleDifficultyTableViewController: UITableViewController {
    private var category:ArticleCategory = .Art
    private var difficulty:ReadingDifficulty = .Level1
    
    
    func inject(category:ArticleCategory){
        self.category = category
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReadingDifficulty.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReadingDifficultTableViewCell", for: indexPath) as! ReadingDifficultTableViewCell

        cell.levelLabel.text = ReadingDifficulty.allCases[indexPath.row].rawValue

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        difficulty = ReadingDifficulty.allCases[indexPath.row]
        performSegue(withIdentifier: "ReadingDifficultyToArticleSelectSegue", sender: self)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ArticleSelectViewController{
            destination.inject(category: category, difficulty: difficulty)
        }
    }
}
