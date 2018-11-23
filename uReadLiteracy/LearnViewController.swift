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
    
    @IBOutlet var learnTableView: UITableView!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var analyzeButton: UIButton!
    
    @IBOutlet weak var tableview: UITableView!
    
    var helpList = [HelpWordModel]()
    var loginLoadingIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    var sendHelpWord: HelpWordModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(helpList)
        
        self.loginLoadingIndicator.center = CGPoint(x: self.view.frame.size.width / 2.0, y: (self.view.frame.size.height - 100));
        //change center to top of the tableview or first cell^
        self.loginLoadingIndicator.hidesWhenStopped = true
        self.loginLoadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(loginLoadingIndicator)
        //analyzeButton.addTarget(self, action: #selector(analyzeWords), for: .touchUpInside)
    
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHelpWords()
        tableview.reloadData()
    }
    
    func getHelpWords(){
        helpList = HelpWordModel.getWordList()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helpList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "learnCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LearnCell
        
        cell.wordLabel.text = helpList[indexPath.row].getWord()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendHelpWord = helpList[indexPath.row]
        performSegue(withIdentifier: "LearnMoreToDynamicVideoSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DynamicVideoViewController {
            destination.helpWord = sendHelpWord
        }
    }
}
