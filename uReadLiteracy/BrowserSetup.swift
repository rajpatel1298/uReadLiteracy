//
//  BrowserSetup.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/1/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

// MARK: Setup
extension BrowserViewController{
    func setup(){
        logicController = BrowserLogicController(currentArticle: currentArticle)
        
        setupWebview()
        setupHelpFunctionInMenuBar()
        
        recorder = Recorder(delegate:self)
        setupComprehensionPopup()
        
        alerts = BrowserAlerts(viewcontroller: self)
        webviewManager = WebViewManager(webview: webView)
        actitvityIndicator.hidesWhenStopped = true
        
        addGestureRecognizerToCommentBtn()
        commentBtn.autoReverseAnimation = true
        commentBtn.loopAnimation = true
        commentBtn.play()
        commentBtn.contentMode = .scaleAspectFit
    }
    
    private func addGestureRecognizerToCommentBtn(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onCommentSectionBtnPressed))
        commentBtn.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func onCommentSectionBtnPressed(){
        performSegue(withIdentifier: "ReadToCommentSectionSegue", sender: self)
    }
    
    private func setupHelpFunctionInMenuBar(){
        let helpItem = UIMenuItem.init(title: "Help", action: #selector(helpFunction))
        UIMenuController.shared.menuItems = [helpItem]
        UIMenuController.shared.update()
        UIMenuController.shared.setMenuVisible(true, animated: true)
    }
    
    fileprivate func setupComprehensionPopup(){
        let position1 = ComprehensionPopupModel(popupLocation: .Middle, question: "What is Love? Baby don't hurt me, no more!")
        let position2 = ComprehensionPopupModel(popupLocation: .Top, question: "Test Top")
        
        popupManager = ComprehensionPopupManager(popupModels: [position1,position2])
    }
    
    fileprivate func setupWebview(){
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
    }
    
    func setupTopBar(){
        TopToolBarViewController.currentController = self
        TopToolBarViewController.shared.onPreviousBtnPressed = { [weak self] in
            guard let strongself = self else{
                return
            }
            
            if(strongself.webView.canGoBack){
                strongself.webView.goBack()
                
                if(strongself.currentArticle.url == strongself.webView.url?.absoluteString){
                    strongself.popupManager.resetPopupShownStatus()
                }
            }
            else{
                strongself.performSegue(withIdentifier: "unwindToArticleSelectVC", sender: self)
            }
        }
        TopToolBarViewController.shared.onRecordBtnPressed = { [weak self] in
            guard let strongself = self else{
                return
            }
            
            if strongself.recorder.isRecording() {
                strongself.recorder.stopRecording()
            }
            else {
                strongself.recorder.startRecording(filename: strongself.currentArticle.name) { (errStr) in
                    DispatchQueue.main.async {
                        strongself.alerts.showRecordErrorAlert()
                        print(errStr)
                    }
                }
            }
        }
        TopToolBarViewController.shared.onCommentBtnPressed = {
            [weak self] in
            guard let strongself = self else{
                return
            }
            strongself.onCommentSectionBtnPressed()
        }
    }
}
