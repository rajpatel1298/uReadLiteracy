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
    
    var helpWord: HelpWordModel!
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
        helpLabel.text = helpWord.getDescription()
    }
    
    func loadVideoUrlRequests(){
        if(helpWord.isBeginningDifficult()){
            let url = URL(string: "https://www.youtube.com/watch?v=WGERKJYjkQI") //no beginning video yet
            let request = URLRequest(url: url!)
            videoUrlRequests.append(request)
        }
        if(helpWord.isEndingDifficult()){
            let url = URL(string: "https://www.youtube.com/watch?v=WGERKJYjkQI")
            let request = URLRequest(url: url!)
            videoUrlRequests.append(request)
        }
        if(helpWord.isBlendDifficult()){
            let url = URL(string: "https://www.youtube.com/watch?v=k-n_LHGseNk")
            let request = URLRequest(url: url!)
            videoUrlRequests.append(request)
        }
        if(helpWord.isMultisyllabicDifficult()){
            let url = URL(string: "https://www.youtube.com/watch?v=vNR2xyrZVv0")
            let request = URLRequest(url: url!)
            videoUrlRequests.append(request)
        }
    }

}
