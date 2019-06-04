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
        tableview.separatorColor = UIColor.white
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WordWithDeleteBtnTableViewCell
        
        cell.wordLabel.text = helpList[indexPath.row].word
        cell.wordLabel.textColor = UIColor.white
    
        
        cell.resetDeleteBtn()
        cell.inject(onDelete: { [weak self] in
            guard let strongself = self else {
                return
            }
            
            let alertController = UIAlertController(title: "Delete Help Word", message: "Are you sure you want to delete \"\(strongself.helpList[indexPath.row].word)\"?", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action) in
                DispatchQueue.main.async {
                    CoreDataUpdater.shared.delete(helpModel: strongself.helpList[indexPath.row])
                    strongself.helpList.remove(at: indexPath.row)
                    strongself.tableview.reloadData()
                    NotificationManager.shared.notifyHelpWordsUpdated()
                }
            }))
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                DispatchQueue.main.async {
                    alertController.dismiss(animated: true, completion: nil)
                }
            }))
            strongself.present(alertController, animated: true, completion: nil)
            
        })
        
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
