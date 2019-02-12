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
    
    
    init(viewcontroller:BrowseViewController){
        self.viewcontroller = viewcontroller
        setupAlert()
        setupHelpFunctionInMenuBar()
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


