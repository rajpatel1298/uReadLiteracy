//
//  RecordViewController.swift
//  uReadLiteracy
//
//

import UIKit
import AVFoundation


class RecordViewController: UIViewController, AVAudioRecorderDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    private var titlesWithModels = [String:[AudioRecordModel]]()
    
    private var selectedTitle:[AudioRecordModel]!

    private var noResultController:NoResultViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noResultController = (storyboard!.instantiateViewController(withIdentifier: "NoResultViewController") as! NoResultViewController)
        noResultController.inject(title: "There is no record!", actionStr: "Record You Reading Articles", action: {
            DispatchQueue.main.async {
                self.tabBarController?.selectedIndex = 2
            }
        })
        add(noResultController)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListTitleWithoutDuplicate()
        tableview.reloadData()
        showNoResultControllerIfNeeded()
        TopToolBarViewController.currentController = self
    }
    
    func showNoResultControllerIfNeeded(){
        if titlesWithModels.count == 0{
            noResultController.view.isHidden = false
            tableview.isHidden = true
        }
        else{
            noResultController.view.isHidden = true
            tableview.isHidden = false
        }
    }
        
    private func getListTitleWithoutDuplicate(){
        titlesWithModels.removeAll()
        
        let models:[AudioRecordModel] = CoreDataGetter.shared.getList()
        
        for model in models{
            if titlesWithModels[model.getTitle()] == nil{
                titlesWithModels[model.getTitle()] = [AudioRecordModel]()
                titlesWithModels[model.getTitle()]?.append(model)
            }
            else{
                titlesWithModels[model.getTitle()]?.append(model)
            }
        }
    }

    //setting up table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesWithModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! RecordCell
        cell.titleLabel?.text = titlesWithModels.keys.sorted()[indexPath.row]
        return cell
    }
    
    //listen to the selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let titles = titlesWithModels.keys.sorted()
        selectedTitle = titlesWithModels[titles[indexPath.row]]
        performSegue(withIdentifier: "RecordToAudioRecordsSegue", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RecordsDetailViewController{
            destination.audioRecords = selectedTitle
        }
    }

}
