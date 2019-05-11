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
    fileprivate var sectionExpanded:[String:Bool] = [:]
    
    private let DEFINITION_SECTION_COUNT = 1
    private let DEFINTION = "Definition"
    private let HEADER_HEIGHT:CGFloat = 50
    
    private var wordDefinitions = [String]()
    
    func inject(helpWord:HelpWordModel){
        self.helpWord = helpWord
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.separatorStyle = .none
        tableview.allowsSelection = false
        sectionExpanded[DEFINTION] = false
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
                    let alert = UIAlertController(title: "Cannot Load Help Word", message: "Sorry, Please Try Again!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (_) in
                        
                        strongself.navigationController?.popViewController(animated: true)
                    }))
                    strongself.show(alert, sender: strongself)
                }
                return
            }
            
            
            
            DispatchQueue.main.async {
                strongself.activityIndicator.stopAnimating()
                strongself.activityIndicator.isHidden = true
                
                strongself.wordDetails = WordAnalyzer.getDetails(helpWord: strongself.helpWord)
                strongself.wordDefinitions = DictionaryManager.shared.getDefinitions(from: dictionaryWord)
                
                
                strongself.sectionExpanded.removeAll()
                strongself.sectionExpanded[strongself.DEFINTION] = false
                for detail in strongself.wordDetails{
                    strongself.sectionExpanded[detail.title] = false
                }
                
                
                strongself.tableview.reloadData()
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return wordDetails.count + DEFINITION_SECTION_COUNT
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        var title = ""
 
        let sectionIndexWithoutDefinition = section - 1
        
        if(section == 0){
            if(sectionExpanded[DEFINTION] == nil){
                fatalError("sectionExpanded setup wrong")
            }
            
            title = DEFINTION
        }
        else{
            title = wordDetails[sectionIndexWithoutDefinition].title
            if(sectionExpanded[title] == nil){
                fatalError("sectionExpanded setup wrong")
            }
        }
        
        
        let header = DropDownView(title: title, expanded: sectionExpanded[title]!, frame: CGRect(x: 0, y: 0, width: view.frame.width, height: HEADER_HEIGHT), delegate: self)
  
        return header
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return HEADER_HEIGHT
        }
        let definitionSection = 1
        let lastSection = section - 1
        if(lastSection == 0){
            return HEADER_HEIGHT
        }
        else if(wordDetails[lastSection - definitionSection].title == wordDetails[section - definitionSection].title){
            return 0
        }
        return HEADER_HEIGHT
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            if(sectionExpanded[DEFINTION] == nil){
                fatalError("sectionExpanded setup wrong")
            }
            if(sectionExpanded[DEFINTION]!){
                return wordDefinitions.count
            }
            return 0
        }
                
        let wordAnalysis = 1
        
        let detail = wordDetails[section-wordAnalysis]
        
        if(sectionExpanded[detail.title] == nil){
            fatalError("sectionExpanded setup wrong")
        }
        
        let expanded = sectionExpanded[detail.title]!
        if(!expanded){
            return 0
        }
        
        let sectionIndexWithoutDefinition = section - 1
        
        return wordAnalysis +  wordDetails[sectionIndexWithoutDefinition].videoHtmlList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
            let cell = tableview.dequeueReusableCell(withIdentifier: "WordWithSpeakerTableViewCell") as! WordWithSpeakerTableViewCell
            return cell
        }
        else{
            let sectionIndexWithoutDefinition = indexPath.section-1
            let detail = wordDetails[sectionIndexWithoutDefinition]
            
            if(indexPath.row == 0){
                let cell = tableview.dequeueReusableCell(withIdentifier: "WordAnalysisTableViewCell") as! WordAnalysisTableViewCell
                cell.detailLabel.text = detail.detail
                return cell
            }
            else{
                let urlIndex =  (indexPath.row - 1)
                
                let cell = tableview.dequeueReusableCell(withIdentifier: "DynamicVideoTableViewCell") as! DynamicVideoTableViewCell
                cell.html = detail.videoHtmlList[urlIndex]
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        //WordWithSpeakerTableViewCell
        if(indexPath.section == 0){
            return 100
        }
        else{
            //WordAnalysisTableViewCell
            if(indexPath.row == 0){
                return 100
            }
            // DynamicVideoTableViewCell
            else{
                return 300
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //WordWithSpeakerTableViewCell
        if(indexPath.section == 0){
            return UITableViewAutomaticDimension
        }
        else{
            //WordAnalysisTableViewCell
            if(indexPath.row == 0){
                return UITableViewAutomaticDimension
            }
                // DynamicVideoTableViewCell
            else{
                return 300
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? DynamicVideoTableViewCell{
            cell.webview.loadHTMLString(cell.html, baseURL: nil)
            cell.webview.scrollView.isScrollEnabled = false
        }
        if let cell = cell as? WordWithSpeakerTableViewCell{
            if(indexPath.row == 0){
                cell.titleLabel.font = UIFont(name: "NokioSans-Bold", size: 20)
            }
            else{
                cell.titleLabel.font = UIFont(name: "NokioSans-Regular", size: 20)
            }
        
            cell.titleLabel.text = wordDefinitions[indexPath.row]
        }
    }
}

extension LearnDetailViewController:DropDownDelegate{
    func dropDownChanged(dropDownTitle: String) {
        
        if(sectionExpanded[dropDownTitle] == nil){
            fatalError("sectionExpanded setup wrong")
        }
        sectionExpanded[dropDownTitle] = !sectionExpanded[dropDownTitle]!
        tableview.reloadData()
    }
}
