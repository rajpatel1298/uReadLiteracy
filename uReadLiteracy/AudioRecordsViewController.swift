//
//  AudioRecordsViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/28/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit
import AVFoundation

class AudioRecordsViewController: UIViewController,AVAudioRecorderDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var audioRecords:[AudioRecordModel]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        audioRecords.sort { (m1, m2) -> Bool in
            return m1.getDate() > m2.getDate()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audioRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AudioRecordsCell") as! AudioRecordsCell
        cell.dateLabel.text = audioRecords[indexPath.row].getDate().toString()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
