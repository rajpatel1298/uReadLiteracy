//
//  LearnDetailViewController.swift
//  uReadLiteracy
//
//  Created by Raj Patel on 7/11/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import WebKit


class LearnDetailViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    private var helpWord: HelpWordModel!
    private var wordDetails = [WordAnalysisDetail]()
    
    private var definition = ""
    private var wordDetailsCellIndices = [Int:UITableViewCell]()
    private let DEFINITION_COUNT = 1
    
    func inject(helpWord:HelpWordModel){
        self.helpWord = helpWord
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.separatorStyle = .none
        tableview.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TopToolBarViewController.shared.hidePreviousCommentRecordBtn()
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        
        
        DictionaryManager.shared.getDictionaryWord(word: helpWord.word) { [weak self] (dictionaryWord) in
            
            guard let strongself = self else{
                return
            }
            
            guard let dictionaryWord = dictionaryWord else{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Cannot Load Help Word", message: "Sorry, Please Try Again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (_) in
                        strongself.dismiss(animated: true, completion: nil)
                    }))
                    strongself.show(alert, sender: strongself)
                }
                return
            }
            
            
            
            DispatchQueue.main.async {
                strongself.activityIndicator.stopAnimating()
                strongself.activityIndicator.isHidden = true
                
                strongself.wordDetails = WordAnalyzer.getDetails(helpWord: strongself.helpWord)
                strongself.setWordDetailsCellIndices()
                strongself.definition = DictionaryManager.shared.getDefinition(from: dictionaryWord)
                
                strongself.tableview.reloadData()
            }
        }
    }
    
    private func setWordDetailsCellIndices(){
        wordDetailsCellIndices.removeAll()
        
        var index = 0
        
        for detail in wordDetails{
            let cell = tableview.dequeueReusableCell(withIdentifier: "WordAnalysisTableViewCell") as! WordAnalysisTableViewCell
            cell.detailLabel.text = detail.detail
            wordDetailsCellIndices[index] = cell
            index = index + 1
            
            for request in detail.urlRequests{
                let cell = tableview.dequeueReusableCell(withIdentifier: "DynamicVideoTableViewCell") as! DynamicVideoTableViewCell
                cell.urlrequest = request
                wordDetailsCellIndices[index] = cell
                index = index + 1
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        count = count + DEFINITION_COUNT
        
        for detail in wordDetails{
            count = count + detail.urlRequests.count
        }
        count = count + wordDetails.count
        
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            let cell = tableview.dequeueReusableCell(withIdentifier: "WordWithSpeakerTableViewCell") as! WordWithSpeakerTableViewCell
            return cell
        }
        else{
            let indexForAnalyzer = indexPath.row-DEFINITION_COUNT
            if wordDetailsCellIndices[indexForAnalyzer] == nil{
                fatalError("setup wordDetailsCellIndices hashmap wrong")
            }
            return wordDetailsCellIndices[indexForAnalyzer]!
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        //WordWithSpeakerTableViewCell
        if(indexPath.row == 0){
            return 50
        }
        else{
            let indexForAnalyzer = indexPath.row-DEFINITION_COUNT
            if wordDetailsCellIndices[indexForAnalyzer] == nil{
                fatalError("setup wordDetailsCellIndices hashmap wrong")
            }
            let cell = wordDetailsCellIndices[indexForAnalyzer]!
            if cell is DynamicVideoTableViewCell{
                return 300
            }
            else{
                //WordAnalysisTableViewCell
                return 100
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //WordWithSpeakerTableViewCell
        if(indexPath.row == 0){
            return 50
        }
        else{
            let indexForAnalyzer = indexPath.row-DEFINITION_COUNT
            if wordDetailsCellIndices[indexForAnalyzer] == nil{
                fatalError("setup wordDetailsCellIndices hashmap wrong")
            }
            let cell = wordDetailsCellIndices[indexForAnalyzer]!
            if cell is DynamicVideoTableViewCell{
                return 300
            }
            else{
                //WordAnalysisTableViewCell
                return UITableViewAutomaticDimension
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? DynamicVideoTableViewCell{
            cell.webview.load(cell.urlrequest)
            cell.webview.scrollView.isScrollEnabled = false
        }
        if let cell = cell as? WordWithSpeakerTableViewCell{
            if(indexPath.row == 0){
                cell.titleLabel.font = UIFont(name: "NokioSans-Bold", size: 20)
            }
            else{
                cell.titleLabel.font = UIFont(name: "NokioSans-Regular", size: 20)
            }
            
            cell.titleLabel.text = "Definition"
            cell.definition = definition
        }
        
    }
}
