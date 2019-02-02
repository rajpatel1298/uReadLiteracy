//
//  BrowserUIController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/20/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import WebKit
import UIKit

class BrowserUIController{
    let viewcontroller:BrowseViewController
    
    fileprivate var onlyOneWordAlert:InfoAlert!
    fileprivate var cannotUseHelpFunctionAlert:ReportAlert!
    fileprivate var recordErrorAlert:InfoAlert!
    let popupManager = ComprehensionPopupManager()
    
    init(viewcontroller:BrowseViewController){
        self.viewcontroller = viewcontroller
        setupAlert()
        setupHelpFunctionInMenuBar()
    }
    
    
    
    func readScrollViewPosition(){
        showSocialMediaViewIfNeeded()
        showPopupIfNeeded()
    }
}

// MARK: Alert
extension BrowserUIController{
    func handleHelpError(helpFunctionError: HelpFunctionError){
        switch(helpFunctionError){
        case .MoreThanOneWord:
            showOnlyOneWordAlert()
            break
        case .UnknownError:
            break
        }
    }
    
    func showOnlyOneWordAlert(){
        onlyOneWordAlert.show()
    }
    
    func showCannotUseHelpFunctionAlert(){
        cannotUseHelpFunctionAlert.show()
    }
    
    func showRecordErrorAlert(){
        recordErrorAlert.show()
    }
}

// MARK: Setup
extension BrowserUIController{
    fileprivate func setupHelpFunctionInMenuBar(){
        let helpItem = UIMenuItem.init(title: "Help", action: #selector(viewcontroller.helpFunction))
        UIMenuController.shared.menuItems = [helpItem]
        UIMenuController.shared.update()
        UIMenuController.shared.setMenuVisible(true, animated: true)
    }
    
    fileprivate func setupAlert(){
        onlyOneWordAlert = InfoAlert(viewcontroller: viewcontroller, title: "1 Word Only", message: "Please choose only one word to use Help function")
        cannotUseHelpFunctionAlert = ReportAlert(viewcontroller: viewcontroller, title: "Cannot Use Help Function", message: "Please try again alert!")
        recordErrorAlert = InfoAlert(viewcontroller: viewcontroller, title: "Canot Record Audio", message: "Recording failed")
    }
}

// MARK: Social Media
extension BrowserUIController{
    fileprivate func showSocialMediaViewIfNeeded(){
        let currentYOffset = Int(viewcontroller.webView.scrollView.contentOffset.y)
        let maxBrowserOffset = viewcontroller.maxBrowserOffset
        
        if maxBrowserOffset == nil{
            return
        }
        
        if !viewcontroller.isReadingAnArticle(){
            return
        }
        
        if currentYOffset >= maxBrowserOffset!*90/100 && maxBrowserOffset! > 0{
            if viewcontroller.socialMediaView.isHidden{
                viewcontroller.socialMediaView.isHidden = false
                viewcontroller.socialMediaView.alpha = 0
                
                UIView.animate(withDuration: 1) {
                    self.viewcontroller.webView.frame = CGRect(x: self.viewcontroller.view.frame.origin.x, y: self.viewcontroller.view.frame.origin.y, width: self.viewcontroller.view.frame.width, height: self.viewcontroller.view.frame.height/2)
                    self.viewcontroller.socialMediaView.alpha = 1
                }
            }
        }
        else{
            if !viewcontroller.socialMediaView.isHidden{
                viewcontroller.socialMediaView.alpha = 1
                
                UIView.animate(withDuration: 1, animations: {
                    self.viewcontroller.webView.frame = self.viewcontroller.view.frame
                    self.viewcontroller.socialMediaView.alpha = 0
                }) { (completed) in
                    if completed{
                        self.viewcontroller.socialMediaView.isHidden = true
                    }
                }
            }
        }
    }
}

// MARK: Comprehension Popup
extension BrowserUIController{
    func updatePopupManager(){
        let webview = viewcontroller.webView!
        
        let maxOffset = webview.scrollView.contentSize.height - webview.scrollView.bounds.height + webview.scrollView.contentInset.bottom
        
        popupManager.setMaxYOffset(value: maxOffset)
        popupManager.setYOffsetsToShowPopup(showAtYOffsets: [ComprehensionPopupShowPoint(y: maxOffset/2)])
    }
    
    fileprivate func showPopupIfNeeded(){
        if !viewcontroller.isReadingAnArticle(){
            return
        }
        
        let currentYOffset = viewcontroller.webView.scrollView.contentOffset.y
        
        if popupManager.shouldShowPopup(currentYOffset: currentYOffset){
            viewcontroller.webView.scrollView.setContentOffset(CGPoint(x: viewcontroller.webView.scrollView.contentOffset.x, y: currentYOffset), animated: true)
            
            let popup = ComprehensionPopup(frame: viewcontroller.view.frame)
            
            popup.setupClosure(onAccept: { (answer) in
                print("answer for now: \(answer)")
            }, onSkip: {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: popup.animationDuration, animations: {
                        popup.alpha = 0
                    }, completion: { (_) in
                        //self.popup.removeFromSuperview() does not work :(
                        for subview in self.viewcontroller.view.subviews{
                            if subview is ComprehensionPopup{
                                subview.removeFromSuperview()
                            }
                        }
                    })
                }
            })
            
            viewcontroller.view.addSubview(popup)
            
            popup.alpha = 0
            UIView.animate(withDuration: popup.animationDuration) {
                popup.alpha = 1
            }
        }
    }
}
