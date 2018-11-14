//
//  DynamicVideoViewController.swift
//  uReadLiteracy
//
//  Created by Raj Patel on 7/11/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import WebKit

class DynamicVideoViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var helpLabel: UILabel!
    
    var helpWord: HelpWord!
    var videoUrlRequests = [URLRequest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadHelpLabel()
        loadVideoUrlRequests()
        
        tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoUrlRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "DynamicVideoTableViewCell") as! DynamicVideoTableViewCell
        cell.webview.scrollView.isScrollEnabled = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! DynamicVideoTableViewCell
        cell.webview.load(videoUrlRequests[indexPath.row])
    }

    func loadHelpLabel(){
        var string = "The word: \(helpWord.word!) might be difficult because of:\n"
        
        if(helpWord.beginningDifficult){
            string.append("- Its beginning\n")
        }
        if(helpWord.endingDifficult){
            string.append("- Its ending\n")
        }
        if(helpWord.blendDifficult){
            string.append("- It has a blend\n")
        }
        if(helpWord.blendDifficult){
            string.append("- It is multisyllabic\n")
        }
        
        string.append("\nWatch these videos to learn more.")
        
        helpLabel.text = string
    }
    
    func loadVideoUrlRequests(){
        if(helpWord.beginningDifficult){
            let url = URL(string: "https://www.youtube.com/watch?v=WGERKJYjkQI") //no beginning video yet
            let request = URLRequest(url: url!)
            videoUrlRequests.append(request)
        }
        if(helpWord.endingDifficult){
            let url = URL(string: "https://www.youtube.com/watch?v=WGERKJYjkQI")
            let request = URLRequest(url: url!)
            videoUrlRequests.append(request)
        }
        if(helpWord.blendDifficult){
            let url = URL(string: "https://www.youtube.com/watch?v=k-n_LHGseNk")
            let request = URLRequest(url: url!)
            videoUrlRequests.append(request)
        }
        if(helpWord.blendDifficult){
            let url = URL(string: "https://www.youtube.com/watch?v=vNR2xyrZVv0")
            let request = URLRequest(url: url!)
            videoUrlRequests.append(request)
        }
    }

}
