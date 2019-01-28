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
    
    private var title:String!
    private var path:String!
    
    init(delegate:AVAudioRecorderDelegate){
        self.delegate = delegate
        
        recordingSession = AVAudioSession.sharedInstance()
        
        AVAudioSession.sharedInstance().requestRecordPermission { (hasPermission) in
            if hasPermission {
                print("Microphone permission granted")
            }
        }
    }
    
    func startRecording(filename:String, showErrorIfAny:(_ error:String)->Void){
        let pathUrl = getDirectory().appendingPathComponent("\(filename)\(Date().toStringWithoutSpace()).m4a")
        title = filename
        path = pathUrl.absoluteString
        
        let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
        
        do {
            audioRecorder = try AVAudioRecorder(url: pathUrl, settings: settings)
            audioRecorder.delegate = delegate
            
            audioRecorder.record()
        }
        catch {
            showErrorIfAny(error.localizedDescription)
        }
        
        recording = true
    }
    
    func stopRecording(){
        audioRecorder.stop()
        recording = false
        
        let audio = AudioRecordModel(path: path, title: title, date: Date())
        audio.save()
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
