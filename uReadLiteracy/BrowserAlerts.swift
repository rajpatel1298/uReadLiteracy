//
//  BrowserAlerts.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/12/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class BrowserAlerts{
    private var onlyOneWordAlert:InfoAlert!
    private var cannotUseHelpFunctionAlert:ReportAlert!
    private var recordErrorAlert:InfoAlert!
    
    init(viewcontroller:UIViewController){
        setupAlert(viewcontroller: viewcontroller)
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
    
    fileprivate func setupAlert(viewcontroller:UIViewController){
        onlyOneWordAlert = InfoAlert(viewcontroller: viewcontroller, title: "1 Word Only", message: "Please choose only one word to use Help function")
        cannotUseHelpFunctionAlert = ReportAlert(viewcontroller: viewcontroller, title: "Cannot Use Help Function", message: "Please try again alert!")
        recordErrorAlert = InfoAlert(viewcontroller: viewcontroller, title: "Canot Record Audio", message: "Recording failed")
    }
}
