//
//  LearnViewController.swift
//  uReadLiteracy
//
//  Created by Raj Patel on 3/16/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import SafariServices

class LearnViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableview: UITableView!
    
    var helpList = [HelpWordModel]()
    var loginLoadingIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    var sendHelpWord: HelpWordModel!
    
    var noResultController:NoResultViewController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(helpList)
        
        self.loginLoadingIndicator.center = CGPoint(x: self.view.frame.size.width / 2.0, y: (self.view.frame.size.height - 100));
        //change center to top of the tableview or first cell^
        self.loginLoadingIndicator.hidesWhenStopped = true
        self.loginLoadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(loginLoadingIndicator)
    
        noResultController = (storyboard!.instantiateViewController(withIdentifier: "NoResultViewController") as! NoResultViewController)
        noResultController.inject(title: "There is no word to learn!", actionStr: "Read Articles to Learn More Words", action: {
            DispatchQueue.main.async {
                self.tabBarController?.selectedIndex = 2
            }
        })
        add(noResultController)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHelpWords()
        
        if(helpList.count == 0){
            noResultController.view.isHidden = false
            noResultController.animationView.play()
            tableview.isHidden = true
        }
        else{
            noResultController.view.isHidden = true
            noResultController.animationView.stop()
            tableview.isHidden = false
            tableview.reloadData()
        }
        
        TopToolBarViewController.currentController = self
        
    }
    
    func getHelpWords(){
        helpList = CoreDataGetter.shared.getList() 
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
        sendHelpWord = helpList[indexPath.row]
        performSegue(withIdentifier: "LearnMoreToDynamicVideoSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LearnDetailViewController {
            destination.inject(helpWord: sendHelpWord)
        }
    }
}
