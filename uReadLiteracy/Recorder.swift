//
//  Recorder.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/26/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class Recorder{
    private var recording = false
    private var recordingSession: AVAudioSession!
    private var audioRecorder: AVAudioRecorder!
    private let delegate:AVAudioRecorderDelegate
    
    init(delegate:AVAudioRecorderDelegate){
        self.delegate = delegate
        
        recordingSession = AVAudioSession.sharedInstance()
        
        AVAudioSession.sharedInstance().requestRecordPermission { (hasPermission) in
            if hasPermission {
                print("Microphone permission granted")
            }
        }
    }
    
    func startRecording(filename:String){
        let filename = getDirectory().appendingPathComponent("\(filename).m4a")
        
        print(filename)
        
        let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
        
        //Start audio recording
        do {
            audioRecorder = try AVAudioRecorder(url: filename, settings: settings)
            audioRecorder.delegate = delegate
            
            audioRecorder.record()
        }
        catch {
            //self.displayAlert(title: "Error", message: "Recording failed")
        }
        
        recording = true
    }
    
    func stopRecording(){
        audioRecorder.stop()
        
       // UserDefaults.standard.set(currentRecording, forKey: "myRecording")

        
        recording = false
    }
    
    func isRecording()->Bool{
        return recording
    }
    
    func getDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
}
