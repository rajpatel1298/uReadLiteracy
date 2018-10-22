//
//  DynamicVideoViewController.swift
//  uReadLiteracy
//
//  Created by Raj Patel on 7/11/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import WebKit

class DynamicVideoViewController: UIViewController {
    
    var helpWord: String!
    var helpFlag: [Int]!
    var finalFlag: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Received this from learn view controller \(helpWord)...")
        print(helpFlag)
        var sortedFlags = helpFlag.sorted()
        
        if(sortedFlags[0] == helpFlag[0]){
            finalFlag = "endings"
        }
        else if(sortedFlags[0] == helpFlag[1]){
            finalFlag = "beginnings"
        }
        else if(sortedFlags[0] == helpFlag[2]){
            finalFlag = "blends"
        }
        else {
            finalFlag = "multisyllabic"
        }
        
        loadVideos()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadVideos(){
        //Add constraints to all views!
        
        let videoOne = WKWebView(frame: CGRect(x: 0, y: 150, width: self.view.frame.width, height: 300), configuration: WKWebViewConfiguration())
        self.view.addSubview(videoOne)
        
        
        let helpText = UILabel(frame: CGRect(x: 0, y: 60, width: self.view.frame.width, height: 20))
        self.view.addSubview(helpText)
    
        if finalFlag == "endings" {
            helpText.text = "The word: \(helpWord!) is difficult because of its ending. Watch these videos to learn more about endings"
            let url = URL(string: "https://www.youtube.com/watch?v=WGERKJYjkQI")
            let request = URLRequest(url: url!)
            videoOne.load(request)
        }
        else if finalFlag == "beginnings" {
            helpText.text = "The word: \(helpWord!) is difficult because of its beginning. Watch these videos to learn more about beginnings"
            let url = URL(string: "https://www.youtube.com/watch?v=WGERKJYjkQI") //no beginning video yet
            let request = URLRequest(url: url!)
            videoOne.load(request)
        }
        else if finalFlag == "blends" {
            helpText.text = "The word: \(helpWord!) is difficult because it has a blend. Watch these videos to learn more about blends"
            let url = URL(string: "https://www.youtube.com/watch?v=k-n_LHGseNk")
            let request = URLRequest(url: url!)
            videoOne.load(request)
        }
        else {
            helpText.text = "The word: \(helpWord!) is difficult because it multisyllabic. Watch these videos to learn more about multisyllabic words"
            let url = URL(string: "https://www.youtube.com/watch?v=vNR2xyrZVv0")
            let request = URLRequest(url: url!)
            videoOne.load(request)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
