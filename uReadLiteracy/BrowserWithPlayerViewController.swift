//
//  BrowserWithPlayerViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 10/28/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import SwiftSoup
import WebKit

class BrowserWithPlayerViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var audioSlider: AudioSlider!
    @IBOutlet weak var audioLabel: AudioTimeLabel!
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var audioView: UIView!
    
    @IBOutlet weak var playerBackground: UIImageView!
    
    var childWebPage:ChildWebPage!
    var audioPlayer:AudioPlayer!
    
    //Observer Patern
    private let subject = AudioSubject()
    private var uiController:BrowserWithPlayerUIController!
    private var controller:BrowserWithPlayerController!
    private var urlForDictionarySegue:URL!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiController = BrowserWithPlayerUIController(viewcontroller: self)
        controller = BrowserWithPlayerController(viewcontroller: self)
        setupHelpFunctionInMenuBar()
    }
    
    private func setupHelpFunctionInMenuBar(){
        let helpItem = UIMenuItem.init(title: "Help", action: #selector(helpFunction))
        UIMenuController.shared.menuItems = [helpItem]
        UIMenuController.shared.update()
        UIMenuController.shared.setMenuVisible(true, animated: true)
    }
    
    func helpFunction(){
        controller.helpFunction { [weak self] (state) in
            switch(state){
            case .Success(let url):
                let url = url as! URL
                
                urlForDictionarySegue = url
                performSegue(withIdentifier: "BrowserToDictionaryWebViewController", sender: self)
                
                break
            case .Failure(let helpFunctionError):
                let helpFunctionError = helpFunctionError as! HelpFunctionError
                
                switch(helpFunctionError){
                case .MoreThanOneWord:
                    uiController.showOnlyOneWordAlert()
                    break
                case .UnknownError:
                    break
                }

                break
            }
        }
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTextView()
        
        
        let mp3Link = getMp3LinkIfExist()
        if(mp3Link == nil){
            playPauseBtn.isEnabled = false
        }
        else{
            playPauseBtn.isEnabled = true
            audioPlayer = AudioPlayer(url: URL(string: mp3Link!)!)
            setupObservers()
        }
        
    }
    
    private func setupTextView(){
        textview.attributedText = nil
        textview.attributedText = childWebPage.getAttributedTextFromURL()
    }
    
    private func setupObservers(){
        subject.attach(observer: audioLabel)
        subject.attach(observer: audioSlider)
        subject.attach(observer: audioPlayer)
        subject.setState(state: .Pause)
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        audioPlayer.pause()
        subject.updateCurrentTime(sliderValue: audioSlider.value)
        DispatchQueue.main.async {
            self.playPauseBtn.setImage(#imageLiteral(resourceName: "pause.png"), for: .normal)
            self.audioPlayer.play()
            self.subject.setState(state: .Play)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        audioPlayer.pause()
    }
    
    @IBAction func playPauseBtnPressed(_ sender: Any) {
        switch(subject.getState()){
        case .Play:
            audioPlayer.pause()
            
            let image = #imageLiteral(resourceName: "play.png")
            let tintedImage = image.withRenderingMode(.alwaysTemplate)
            playPauseBtn.setImage(tintedImage, for: .normal)
            playPauseBtn.tintColor = .white
            subject.setState(state: .Pause)
            break
        case .Pause:
            
            let image = #imageLiteral(resourceName: "pause.png")
            let tintedImage = image.withRenderingMode(.alwaysTemplate)
            playPauseBtn.setImage(tintedImage, for: .normal)
            playPauseBtn.tintColor = .white
            
          //  playPauseBtn.setImage(#imageLiteral(resourceName: "pause.png"), for: .normal)
            audioPlayer.play()
            subject.setState(state: .Play)
            break
        }
    }
    
    
    private func getMp3LinkIfExist()->String?{
        let str = childWebPage.getHtmlString()
        
        if(str == nil){
            return nil
        }
        
        do {
            let doc: Document = try SwiftSoup.parse(str!)
            for link in try doc.select("a[href^=http]"){
  
                for l in try link.getAttributes()!{
                    if(l.getKey() == "href"){
                        if(try l.getValue().suffix(4).lowercased() == ".mp3"){
                            return l.getValue()
                        }
                    }
                }
            }
        } catch let error {
            print("Error: \(error)")
        }
        
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DictionaryWebViewController{
            destination.url = urlForDictionarySegue
        }
    }
    

}
