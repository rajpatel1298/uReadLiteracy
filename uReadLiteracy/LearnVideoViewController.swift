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
    
    
    private var wordCategory:WordCategory = WordCategory.LongVowels
    private var urls = [URLRequest]()
    
    func inject(wordCategory:WordCategory){
        self.wordCategory = wordCategory
        loadUrls()
        tableview.reloadData()
    }
    
    private func loadUrls(){
        switch(wordCategory){
        case .LongVowels:
            urls = LongVowelSoundAnalyzer.getAll()
            break
        case .ShortVowels:
            urls = ShortVowelSoundAnalyzer.getAll()
            break
        case .PrefixSuffix:
            urls = PrefixSuffixAnalyzer.getAll()
            break
        case .Multisyllabic:
            urls = MultisyllabicAnalyzer.getAll()
            break
        case .ConsonantBlends:
            urls = BlendAnalyzer.getAll()
            break
        case .ConsonantDigraphs:
            urls = ConsonantDigraphsAnalyzer.getAll()
            break
        case .Trigraph:
            urls = TrigraphAnalyzer.getAll()
            break
        case .RControlledVowels:
            urls = RControlledVowelsAnalyzer.getAll()
            break
        case .Exceptions:
            urls = OtherCasesWordAnalyzer.getAll()
            break
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "DynamicVideoTableViewCell") as! DynamicVideoTableViewCell
        cell.urlrequest = urls[indexPath.row]
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
