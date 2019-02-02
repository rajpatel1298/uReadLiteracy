//
//  RecordViewController.swift
//  uReadLiteracy
//
//

import UIKit
import AVFoundation


class RecordViewController: UIViewController, AVAudioRecorderDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    private var list = [String:[AudioRecordModel]]()
    private var titles = [String]()
    
    private var selectedTitle:[AudioRecordModel]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myTableView.reloadData()
        getListTitleWithoutDuplicate()
        
        TopToolBarViewController.currentController = self
    }
        
    func getListTitleWithoutDuplicate(){
        list.removeAll()
        
        let models:[AudioRecordModel] = CoreDataManager.shared.getList()
        
        for model in models{
            if list[model.getTitle()] == nil{
                list[model.getTitle()] = [AudioRecordModel]()
                list[model.getTitle()]?.append(model)
            }
            else{
                list[model.getTitle()]?.append(model)
            }
        }
        
        titles = list.keys.sorted()
    }

    //setting up table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! RecordCell
        cell.titleLabel?.text = titles[indexPath.row]
        return cell
    }
    
    //listen to the selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTitle = list[titles[indexPath.row]]
        performSegue(withIdentifier: "RecordToAudioRecordsSegue", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AudioRecordsViewController{
            destination.audioRecords = selectedTitle
        }
    }

}
