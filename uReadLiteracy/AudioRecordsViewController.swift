//
//  AudioRecordsViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/28/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit
import AVFoundation

class AudioRecordsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var playPauseBtn: PlayButton!
    @IBOutlet weak var audioSlider: AudioSlider!
    @IBOutlet weak var audioLabel: AudioTimeLabel!
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var audioPlayerView: UIView!
    
    var audioRecords:[AudioRecordModel]!
    
    var audioPlayer:AudioPlayerWithTimer!
    let subject = AudioSubject()
    
    private var audioPlayerViewHeight:CGFloat = 60
    private var audioPlayerShowing = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        audioRecords.sort { (m1, m2) -> Bool in
            return m1.getDate() > m2.getDate()
        }
        
        audioPlayer = AudioPlayerWithTimer()
        
        subject.attach(observer: audioLabel)
        subject.attach(observer: audioSlider)
        subject.attach(observer: audioPlayer)
        subject.attach(observer: playPauseBtn)
        
        
        audioSlider.isContinuous = false
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sliderTapped(gestureRecognizer:)))
        audioSlider.addGestureRecognizer(tapGestureRecognizer)
        audioSlider.addTarget(self, action: #selector(sliderChanged(gestureRecognizer:)), for: .touchDown)
    }
    
    func sliderChanged(gestureRecognizer: UIGestureRecognizer){
        subject.setState(state: .Pause)
    }
    
    func sliderTapped(gestureRecognizer: UIGestureRecognizer) {
        let pointTapped: CGPoint = gestureRecognizer.location(in: self.view)
        
        let positionOfSlider: CGPoint = audioSlider.frame.origin
        let widthOfSlider: CGFloat = audioSlider.frame.size.width
        let newValue = ((pointTapped.x - positionOfSlider.x) * CGFloat(audioSlider.maximumValue) / widthOfSlider)
        audioSlider.setValue(Float(newValue), animated: true)
        updateAudioPlayerFromSliderValue()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !audioPlayerShowing{
            audioPlayerView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 0)
            tableview.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        audioPlayerShowing = false
    }
    
    @IBAction func playPauseBtnPressed(_ sender: Any) {
        switch(subject.getState()){
        case .Play:
            
            break
        case .Pause:
            
            break
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tabBarHeight = tabBarController?.tabBar.frame.height
        
        audioPlayerShowing = true
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.tableview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - self.audioPlayerViewHeight - tabBarHeight!)
            self.audioPlayerView.frame = CGRect(x: 0, y: self.view.frame.height - self.audioPlayerViewHeight - tabBarHeight!, width: self.view.frame.width, height: self.audioPlayerViewHeight)
        }) { (completed) in
            if completed{
                let url = self.getDirectory().appendingPathComponent(self.audioRecords[indexPath.row].getPath())
                self.audioPlayer.playFile(url: url)
            }
        }
    }
    
    //function that gets path to directory
    func getDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        updateAudioPlayerFromSliderValue()
    }
    
    private func updateAudioPlayerFromSliderValue(){
        subject.updateCurrentTime(sliderValue: audioSlider.value)
        audioPlayer.moveTo(time: subject.getCurrentTime())
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
