//
//  ArticleSelectViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/24/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit

class ArticleSelectViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    private var articles = [ArticleModel]()
    private var selectedArticle = ArticleModel(name: "None", url: "None", category: .Art, difficulty: .Level1)
    private var noResultVC:NoResultViewController!
    
    @IBAction func unwindToArticleSelectVC(segue:UIStoryboardSegue) { }
    
    func inject(category:ArticleCategory, difficulty:ReadingDifficulty){
        articles = ArticleManager.shared.getModels(category: category, diffculty: difficulty)
        setup()
        
        if(articles.count == 0){
            view.bringSubview(toFront: noResultVC.view)
            noResultVC.view.isHidden = false
        }
        else{
            view.sendSubview(toBack: noResultVC.view)
            noResultVC.view.isHidden = true
        }
    }
    
    private func setup(){
        noResultVC = (storyboard!.instantiateViewController(withIdentifier: "NoResultViewController") as! NoResultViewController)
        noResultVC.inject(title: "We don't have any articles with this difficulty right now!", actionStr: "", action: {})
        add(noResultVC)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableview.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        cell.titleLabel.text = articles[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticle = articles[indexPath.row]
        performSegue(withIdentifier: "ArticleSelectToBrowserSegue", sender: self)
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BrowserViewController{
            destination.inject(article: selectedArticle)
        }
    }
}
