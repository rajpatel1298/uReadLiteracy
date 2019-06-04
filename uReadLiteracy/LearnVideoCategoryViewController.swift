//
//  LearnVideoCategoryViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/29/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit

class LearnVideoCategoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    
    private let categories = VideoCategory.allCases
    private var delegate:LearnVideoCategoryDelegate?
    
    func inject(delegate:LearnVideoCategoryDelegate){
        self.delegate = delegate
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LearnVideoCategoryCell", for: indexPath) as! LearnVideoCategoryTableViewCell
        
        cell.wordLabel.text = categories[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selected(category: categories[indexPath.row])
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.separatorColor = UIColor.white
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
