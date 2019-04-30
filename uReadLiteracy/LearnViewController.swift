//
//  LearnViewController.swift
//  uReadLiteracy
//
//  Created by Raj Patel on 3/16/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import SafariServices

class LearnViewController: UIViewController{
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var containerView: UIView!
    
    fileprivate var selectedHelpWord = HelpWordModel(word: "Nothing")
    fileprivate var selectedWordCategory:WordCategory = WordCategory.LongVowels
    
    private var noResultController:NoResultViewController!
    private var learnWordController:LearnWordViewController!
    private var learnVideoCategoryController:LearnVideoCategoryViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noResultController = (storyboard!.instantiateViewController(withIdentifier: "NoResultViewController") as! NoResultViewController)
        noResultController.inject(title: "There is no word to learn!", actionStr: "Read Articles to Learn More Words", action: {
            DispatchQueue.main.async {
                self.tabBarController?.selectedIndex = 2
            }
        })
        add(noResultController)
        
        learnWordController = (storyboard!.instantiateViewController(withIdentifier: "LearnWordViewController") as! LearnWordViewController)
        add(learnWordController)
        
        learnVideoCategoryController = (storyboard!.instantiateViewController(withIdentifier: "LearnVideoCategoryViewController") as! LearnVideoCategoryViewController)
        add(learnVideoCategoryController)
    }
    
    private func setupUIBasedOnSegmentedControl(){
        if segmentedControl.selectedSegmentIndex == 0{
            learnWordController.view.isHidden = false
            learnVideoCategoryController.view.isHidden = true
            view.bringSubview(toFront: learnWordController.view)
            view.sendSubview(toBack: learnVideoCategoryController.view)
            
            let helpWords:[HelpWordModel] = CoreDataGetter.shared.getList()
            
            if(helpWords.count == 0){
                noResultController.view.isHidden = false
                noResultController.animationView.play()
                learnWordController.hideTableView()
            }
            else{
                noResultController.view.isHidden = true
                noResultController.animationView.stop()
                learnWordController.reloadTableView()
                learnWordController.showTableView()
            }
        }
        else{
            learnWordController.view.isHidden = true
            learnVideoCategoryController.view.isHidden = false
            view.bringSubview(toFront: learnVideoCategoryController.view)
            view.sendSubview(toBack: learnWordController.view)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        learnWordController.inject(helpList: CoreDataGetter.shared.getList(), delegate: self)
        
        setupUIBasedOnSegmentedControl()
        TopToolBarViewController.currentController = self
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LearnDetailViewController {
            destination.inject(helpWord: selectedHelpWord)
        }
        else if let destination = segue.destination as? LearnVideoViewController {
            destination.inject(wordCategory: selectedWordCategory)
        }
    }
}

extension LearnViewController:LearnWordDelegate{
    func selectWord(word: HelpWordModel) {
        selectedHelpWord = word
        performSegue(withIdentifier: "LearnToLearnDetailSegue", sender: self)
    }
}

extension LearnViewController:LearnVideoCategoryDelegate{
    func selected(category: WordCategory) {
        self.selectedWordCategory = category
        performSegue(withIdentifier: "LearnToLearnVideoSegue", sender: self)
    }
}
