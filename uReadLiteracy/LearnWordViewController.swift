//
//  LearnWordViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/29/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit

class LearnWordViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private var helpList = [HelpWordModel]()
    private var delegate:LearnWordDelegate?
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helpList = CoreDataGetter.shared.getList()
    }
    
    func inject(helpList: [HelpWordModel], delegate:LearnWordDelegate){
        self.helpList = helpList
        self.delegate = delegate
    }
    
    func hideTableView(){
        tableview.isHidden = true
    }
    
    func showTableView(){
        tableview.isHidden = false
    }
    
    func reloadTableView(){
        tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helpList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "learnCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LearnCell
        
        cell.wordLabel.text = helpList[indexPath.row].word
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectWord(word: helpList[indexPath.row])
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
