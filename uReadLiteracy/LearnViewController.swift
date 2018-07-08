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
    var helpList = [String]()
    var loginLoadingIndicator : UIActivityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        print(helpList)
        
        self.loginLoadingIndicator.center = CGPoint(x: self.view.frame.size.width / 2.0, y: (self.view.frame.size.height - 100));
        //change center to top of the tableview or first cell^
        self.loginLoadingIndicator.hidesWhenStopped = true
        self.loginLoadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(loginLoadingIndicator)
        analyzeButton.addTarget(self, action: #selector(analyzeWords), for: .touchUpInside)
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleClose(sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helpList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "learnCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LearnCell
        
        cell.wordLabel.text = helpList[indexPath.row]
        
        return cell
    }
    
    func isVowel(letter: Character) -> Bool{
        if(letter == "a" || letter == "e" || letter == "i" || letter == "o" || letter == "u"){
            return true
        }
        return false
    }
    
    func analyzeWords(){
        self.loginLoadingIndicator.startAnimating()
        var endHelp = 0
        var begHelp = 0
        var blends = 0
        var multi = 0
        
        let beginnings = ["bl", "br", "ch", "ci", "cl", "cr", "dis", "dr", "dw", "ex", "fl", "fr", "gl", "gr", "in","kn", "ph", "pl", "pr", "psy", "re", "sc", "sh", "shr", "sk", "sl","sm", "sn", "sp", "spr", "st", "str", "sw", "th", "thr", "tr", "tw", "un", "wh", "wr","eigh"]
        
        let endings = ["augh", "cial", "cian", "ck", "dge", "ed", "ful", "gh", "ght", "ing", "ious", "ld", "le", "lf", "lk", "lm", "lp", "lt", "ly", "ment", "mp", "nce", "nch", "nd", "nk", "nse", "nt","ough","over", "psy", "pt", "tien", "tion", "ture"]
        
        //calculate number of difficult ending words
        for end in endings {
            for word in helpList {
                let currEnd = end;
                if(word.hasSuffix(currEnd) == true){
                    endHelp = endHelp + 1
                }
            }
        }
        
        //calculate number of difficult beginning words
        for beg in beginnings{
            for word in helpList {
                let currBeg = beg
                if(word.hasPrefix(currBeg) == true){
                    begHelp = begHelp + 1
                }
            }
        }
        
        //calculate word blends
        var counter = 0;
        
        for string in helpList {
        //   string = string.lowercased()
            for char in string.enumerated() {
                if ((counter == 1) && (isVowel(letter: char.element) || (char.element == "y" || char.element == "w"))){
                    blends += 1
                    counter = 0
                } else if(isVowel(letter: char.element)){
                    counter += 1
                } else {
                    counter = 0
                }
            }
        }
        
        //calculate multisyllabic words
        counter = 0
        for string2 in helpList {
            for char in string2.enumerated() {
                
                if counter == 1 && isVowel(letter: char.element) {
                    multi += 1
                    counter = 0
                }
                else if (counter == 1 && !isVowel(letter: char.element)) {
                    //continue
                }
                else if (counter == 0 && isVowel(letter: char.element)){
                    counter = 1
                }
                else {
                    //do nothing
                }
            }
        }
        
        //compare whichever is the highest and the display the corresponding page with youtube links
        var words = [endHelp, begHelp, blends, multi]
        words.sort()
        
        if(words[0] == endHelp){
            //display endHelp video pages
        }
        else if(words[0] == begHelp) {
            //display begHelp video pages
        }
        else if(words[0] == multi){
            //display multi
        }
        else {
            //display blends 
        }
        
        self.loginLoadingIndicator.stopAnimating()
        
        if let url = URL(string: "https://www.youtube.com/watch?v=N5Qu7Qlf_eI"){
            let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true, completion: nil)
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
