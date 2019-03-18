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
    @IBOutlet weak var helpLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    private var helpWord: HelpWordModel!
    private var youtubeUrlRequests = [URLRequest]()
    
    private var titles = [String]()
    private var titleWithDefinition = [String:String]()
    
    func inject(helpWord:HelpWordModel){
        self.helpWord = helpWord
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TopToolBarViewController.shared.hidePreviousAndRecordBtn()
        
        helpLabel.text = helpWord.getDescription()
        
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
            
            strongself.titleWithDefinition = DictionaryManager.shared.getTitlesWithDefinition(from: dictionaryWord)
            strongself.titles = DictionaryManager.shared.getTitles(from: dictionaryWord)
            
            strongself.youtubeUrlRequests = YoutubeURLRequestManager.shared.get(helpWord: strongself.helpWord)
            
            DispatchQueue.main.async {
                strongself.activityIndicator.stopAnimating()
                strongself.activityIndicator.isHidden = true
                strongself.tableview.reloadData()
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return youtubeUrlRequests.count + titleWithDefinition.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row < titles.count){
            let cell = tableview.dequeueReusableCell(withIdentifier: "WordWithSpeakerTableViewCell") as! WordWithSpeakerTableViewCell
            return cell
        }
        else{
            let cell = tableview.dequeueReusableCell(withIdentifier: "DynamicVideoTableViewCell") as! DynamicVideoTableViewCell
            cell.webview.scrollView.isScrollEnabled = false
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row < titles.count){
            return 50
        }
        else{
            return 300
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? DynamicVideoTableViewCell{
            cell.webview.load(youtubeUrlRequests[indexPath.row-titles.count])
        }
        if let cell = cell as? WordWithSpeakerTableViewCell{
            let title = titles[indexPath.row]
            
            if(indexPath.row == 0){
                cell.titleLabel.font = UIFont(name: "NokioSans-Bold", size: 20)
            }
            else{
                cell.titleLabel.font = UIFont(name: "NokioSans-Regular", size: 20)
            }
            
            cell.titleLabel.text = title
            cell.definition = titleWithDefinition[title]
        }
        
    }
}
