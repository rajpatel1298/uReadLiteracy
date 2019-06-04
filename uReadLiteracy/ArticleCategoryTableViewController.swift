//
//  ArticleCategoryTableViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/25/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit

class ArticleCategoryTableViewController: UITableViewController {

    private var selectedCategory:ArticleCategory = .Art
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArticleCategory.allCases.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCategoryTableViewCell", for: indexPath) as! ArticleCategoryTableViewCell
        
        let category = ArticleCategory.allCases[indexPath.row]

        cell.categoryLabel.text = category.rawValue
        cell.imageview.image = UIImage(imageLiteralResourceName: "\(category.rawValue.replacingOccurrences(of: " ", with: "").lowercased()).jpg")

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = ArticleCategory.allCases[indexPath.row]
        performSegue(withIdentifier: "ArticleCategoryToDifficultySegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ArticleDifficultyViewController{
            destination.inject(category: selectedCategory)
        }
    }
}
