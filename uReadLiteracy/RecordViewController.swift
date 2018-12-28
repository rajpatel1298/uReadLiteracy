//
//  RecordViewController.swift
//  uReadLiteracy
//
//

import UIKit
import AVFoundation


class RecordViewController: UIViewController, AVAudioRecorderDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var numberOfRecords: Int = 0
    var recordsList:[String] = []
    var currentRecording: String = "";

    
    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    
    @IBAction func record(_ sender: Any) {
        //Check if we have an active recorder
        if audioRecorder == nil {
            numberOfRecords += 1
            
            let alert = UIAlertController(title: "New Recording", message: "Enter a name for your recording",
                                          preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.text = "New Recording Name"
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert!.textFields![0]
                self.currentRecording = textField.text!
            }))
            
            self.present(alert,animated:true,completion:nil)
            
            let filename = getDirectory().appendingPathComponent("\(currentRecording).m4a")
        
            let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
            
           //  recordsList.append(currentRecording)
            //Start audio recording
            do {
                audioRecorder = try AVAudioRecorder(url: filename, settings: settings)
                audioRecorder.delegate = self
                audioRecorder.record()
                
                buttonLabel.setTitle("Stop Recording", for: .normal)
            }
            catch {
                displayAlert(title: "Error", message: "Recording failed")
            }
        }
        else {
            //stopping audio recording
            audioRecorder.stop()
            audioRecorder = nil
            
            UserDefaults.standard.set(numberOfRecords, forKey: "myNumber")
            UserDefaults.standard.set(currentRecording, forKey: "myRecording")
            
            recordsList.append(currentRecording)
            print("Added \(currentRecording) at index: \(String(describing: recordsList.firstIndex(of: currentRecording) ?? nil))")
            myTableView.reloadData()
            
            buttonLabel.setTitle("Start Recording", for: .normal)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //setting up session
        recordingSession = AVAudioSession.sharedInstance()
        
        //gets last used number for recording
        if let number: Int = UserDefaults.standard.object(forKey: "myNumber") as? Int {
            numberOfRecords = number
        }
        
        AVAudioSession.sharedInstance().requestRecordPermission { (hasPermission) in
            if hasPermission {
                print("Permission granted")
            }
        }
    }
    
    //function that gets path to directory
    func getDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
    
    //function that displays an alert
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    //setting up table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = recordsList[indexPath.row]
        return cell
    }
    
    //listen to the selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let path = getDirectory().appendingPathComponent("\(recordsList[indexPath.row]).m4a")
        print("trying to play : \(recordsList[indexPath.row]).m4a")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: path)
            audioPlayer.play()
        }
        catch {
            print("Playback failed")
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
