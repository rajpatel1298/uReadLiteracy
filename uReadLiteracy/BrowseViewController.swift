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
import FirebaseAuth

class BrowseViewController: UIViewController, WKNavigationDelegate,UIScrollViewDelegate,AVAudioRecorderDelegate,AVAudioPlayerDelegate{
    
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var previousPageBarBtn: UIBarButtonItem!
    @IBOutlet weak var recordBarBtn: UIBarButtonItem!
    @IBOutlet weak var socialMediaView: UIView!
    
    

    var urlSegue:URL!
    let mainUrl = "http://www.manythings.org/voa/stories/"
    
    var uiController:BrowserUIController!
    var controller:BrowserController!
    
    var currentArticle:ArticleModel?
    
    
    private var browserSocialMediaVC:BrowserSocialMediaViewController!
    
    var maxBrowserOffset:Int!
    
    var recorder:Recorder!
    
    var player:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiController = BrowserUIController(viewcontroller: self)
        controller = BrowserController(webView: webView, url: mainUrl)
        
        webView.navigationDelegate = self
    
        webView.scrollView.delegate = self
    
        browserSocialMediaVC = (childViewControllers.first as! BrowserSocialMediaViewController)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webView.frame = view.frame
        socialMediaView.frame = CGRect(x: view.frame.origin.x, y: view.frame.height/2, width: view.frame.width, height: view.frame.height/2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        previousPageBarBtn.isEnabled = false
        loadMainPage()
        socialMediaView.isHidden = true
        webView.frame = view.frame
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webView.frame = view.frame
        loadMainPage()
        socialMediaView.isHidden = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        uiController.readScrollViewPosition()
        updateGoalIfNeeded()
    }
    
    private func updateGoalIfNeeded(){
        let currentYOffset = webView.scrollView.contentOffset.y
        let url = webView.url?.absoluteString
        
        if maxBrowserOffset == nil{
            return
        }
        
        if Int(currentYOffset) >= maxBrowserOffset!*90/100 {
            if(controller.isCurrentURLAnArticle(url: url!)){
                if(currentArticle != nil){
                    currentArticle?.stopRecordingTime()
                    GoalManager.shared.updateGoals(article: currentArticle!)
                }
            }
        }
    }
    
    func loadMainPage(){
        let url = URL(string: mainUrl)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    @IBAction func previousBtnPressed(_ sender: Any) {
        webView.goBack()
    }
    
    // when go to new webpage
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if(webView.canGoBack){
            previousPageBarBtn.isEnabled = true
        }
        else{
            previousPageBarBtn.isEnabled = false
        }
        
        let url = webView.url?.absoluteString
        
        if isReadingAnArticle(){
            currentArticle = ArticleModel(name: webView.title!, url: url!)
            currentArticle?.incrementReadCount()
            currentArticle?.startRecordingTime()
            
            maxBrowserOffset = Int(webView.scrollView.contentSize.height - webView.scrollView.bounds.height + webView.scrollView.contentInset.bottom)
            
            updatePopupManager()
            
            browserSocialMediaVC.currentArticle = currentArticle
            
            recorder = Recorder(delegate:self)
            
            let selectedSound = recorder.getDirectory().appendingPathComponent("\((currentArticle?.getTitle())!).m4a")
            let url = selectedSound
    
            
            do {
                player = try AVAudioPlayer(contentsOf: url)
                
                
                player.delegate = self
                player.prepareToPlay()
                player.play()
            }
            catch {
                print("Something bad happened. Try catching specific errors to narrow things down",error)
            }
            
            
            //player?.delegate = self
            //try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            //player?.prepareToPlay()
            
        }
        
        else{
            uiController.popupManager.reset()
        }
    }
    
    func isReadingAnArticle()->Bool{
        let url = webView.url?.absoluteString
        return controller.isCurrentURLAnArticle(url: url!)
    }
    
    private func updatePopupManager(){
        let maxOffset = webView.scrollView.contentSize.height - webView.scrollView.bounds.height + webView.scrollView.contentInset.bottom
        
        uiController.popupManager.setMaxYOffset(value: maxOffset)
        uiController.popupManager.setYOffsetsToShowPopup(showAtYOffsets: [ComprehensionPopupShowPoint(y: maxOffset/2)])
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
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        self.recorder.stopRecording()
    }
    
    @IBAction func record(_ sender: Any) {
        if recorder.isRecording() {
            recordBarBtn.title = "Record"
            recorder.stopRecording()
        }
        else {
            recorder.startRecording(filename: (currentArticle?.getTitle())!)
            recordBarBtn.title = "Stop Recording"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DictionaryWebViewController{
            destination.url = urlSegue
        }
    }
    
    
}





