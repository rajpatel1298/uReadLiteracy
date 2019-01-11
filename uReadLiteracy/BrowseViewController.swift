//
//  BrowseViewController.swift
//  uReadLiteracy
//
//  Created by Raj Patel on 1/25/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import SafariServices
import WebKit
import SwiftSoup
import AVFoundation

class BrowseViewController: UIViewController, WKNavigationDelegate, AVAudioRecorderDelegate {
    
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var previousPageBarBtn: UIBarButtonItem!
    @IBOutlet weak var recordBarBtn: UIBarButtonItem!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var currentRecording: String = ""
    
    
    var urlSegue:URL!
    let mainUrl = "http://www.manythings.org/voa/stories/"
    
    var uiController:BrowserUIController!
    var controller:BrowserController!
    
    var currentArticle:ArticleModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiController = BrowserUIController(viewcontroller: self)
        controller = BrowserController(webView: webView, url: mainUrl)
        
        webView.navigationDelegate = self
        setupHelpFunctionInMenuBar()
        
        //set up audio session
        recordingSession = AVAudioSession.sharedInstance()
        
        AVAudioSession.sharedInstance().requestRecordPermission { (hasPermission) in
            if hasPermission {
                print("Microphone permission granted")
            }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        previousPageBarBtn.isEnabled = false
        loadMainPage()
    }
    
    func loadMainPage(){
        let url = URL(string: mainUrl)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    @IBAction func previousBtnPressed(_ sender: Any) {
        webView.goBack()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if(webView.canGoBack){
            previousPageBarBtn.isEnabled = true
        }
        else{
            previousPageBarBtn.isEnabled = false
        }
        
        let url = webView.url?.absoluteString
        
        if(controller.articleURL(url: url!)){
            currentArticle = ArticleModel(name: webView.title!, url: url!)
            currentArticle?.incrementReadCount()
            currentArticle?.startRecordingTime()
            //DailyGoalModel.updateGoals(articleUpdate: currentArticle!)
        }
        else{
            currentArticle?.stopRecordingTime()
            if(currentArticle != nil){
                DailyGoalModel.updateGoals(articleUpdate: currentArticle!)
            }
        }
        
    }

    
    
    private func setupHelpFunctionInMenuBar(){
        let helpItem = UIMenuItem.init(title: "Help", action: #selector(helpFunction))
        UIMenuController.shared.menuItems = [helpItem]
        UIMenuController.shared.update()
        UIMenuController.shared.setMenuVisible(true, animated: true)
    }
    
    func helpFunction(){
        controller.helpFunction { [weak self] (state,word) in
            switch(state){
            case .Success(let url):
                HelpWordModel(word: word!).save()
                
                self!.urlSegue = url as! URL
                self!.performSegue(withIdentifier: "BrowserToDictionaryWebViewSegue", sender: self)
                break
            case .Failure(let helpFunctionError):
                let helpFunctionError = helpFunctionError as! HelpFunctionError
                
                switch(helpFunctionError){
                case .MoreThanOneWord:
                    self!.uiController.showOnlyOneWordAlert()
                    break
                case .UnknownError:
                    break
                }
                
                break
            }
        }
    }
   

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DictionaryWebViewController{
            destination.url = urlSegue
        }
    }
    
    @IBAction func record(_ sender: Any) {
        //Check if we have an active recorder
        if audioRecorder == nil {
           
            let alert = UIAlertController(title: "New Recording", message: "Enter a name for your recording",
                                          preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.text = "New Recording Name"
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert!.textFields![0]
                self.currentRecording = textField.text!
                
                let filename = self.getDirectory().appendingPathComponent("\(self.currentRecording).m4a")
                
                let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
                
                //  recordsList.append(currentRecording)
                //Start audio recording
                do {
                    self.audioRecorder = try AVAudioRecorder(url: filename, settings: settings)
                    self.audioRecorder.delegate = self
                    self.audioRecorder.record()
                    
                    self.recordBarBtn.title = "Stop Recording"
                }
                catch {
                    self.displayAlert(title: "Error", message: "Recording failed")
                }
            }))
            
            self.present(alert,animated:true,completion:nil)
            
            
        }
        else {
            //stopping audio recording
            audioRecorder.stop()
            audioRecorder = nil
            
            UserDefaults.standard.set(currentRecording, forKey: "myRecording")
            
            Recordings.sharedInstance.recordingsList.append(currentRecording)
            print("Added \(currentRecording) at index: \(String(describing: Recordings.sharedInstance.recordingsList.firstIndex(of: currentRecording) ?? nil))")
        
            recordBarBtn.title = "Record"
        }
    }
    
    //function that displays an alert
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //function that gets path to directory
    func getDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
}
