//
//  LearnVideoViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/29/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit

class LearnVideoViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var tableview: UITableView!
    
    
    private var wordCategory:VideoCategory = VideoCategory.LongVowels
    private var videoHtmlList = [String]()
    
    func inject(wordCategory:VideoCategory){
        self.wordCategory = wordCategory
        loadUrls()
    }
    
    private func loadUrls(){
        switch(wordCategory){
        case .LongVowels:
            videoHtmlList = LongVowelSoundAnalyzer.getAll()
            break
        case .ShortVowels:
            videoHtmlList = ShortVowelSoundAnalyzer.getAll()
            break
        case .PrefixSuffix:
            videoHtmlList = PrefixSuffixAnalyzer.getAll()
            break
        case .Multisyllabic:
            videoHtmlList = MultisyllabicAnalyzer.getAll()
            break
        case .ConsonantBlends:
            videoHtmlList = BlendAnalyzer.getAll()
            break
        case .ConsonantDigraphs:
            videoHtmlList = ConsonantDigraphsAnalyzer.getAll()
            break
        case .Trigraph:
            videoHtmlList = TrigraphAnalyzer.getAll()
            break
        case .RControlledVowels:
            videoHtmlList = RControlledVowelsAnalyzer.getAll()
            break
        case .Exceptions:
            videoHtmlList = OtherCasesWordAnalyzer.getAll()
            break
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoHtmlList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "DynamicVideoTableViewCell") as! DynamicVideoTableViewCell
        cell.webview.loadHTMLString(videoHtmlList[indexPath.row], baseURL: nil)

        return cell
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableview.reloadData()
    }
    

    /*

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
