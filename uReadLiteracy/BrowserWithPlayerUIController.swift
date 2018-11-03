//
//  BrowserWithAudioPlayerUIController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/2/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class BrowserWithPlayerUIController{
    private let viewcontroller:UIViewController
    
    private var onlyOneWordAlert:InfoAlert!
    private var cannotUseHelpFunctionAlert:ReportAlert!
    
    init(viewcontroller:UIViewController){
        self.viewcontroller = viewcontroller
        setupAlert()
    }
    
    func showOnlyOneWordAlert(){
        onlyOneWordAlert.show()
    }
    
    func showCannotUseHelpFunctionAlert(){
        cannotUseHelpFunctionAlert.show()
    }
    
    private func setupAlert(){
        onlyOneWordAlert = InfoAlert(viewcontroller: viewcontroller, title: "1 Word Only", message: "Please choose only one word to use Help function")
        cannotUseHelpFunctionAlert = ReportAlert(viewcontroller: viewcontroller, title: "Cannot Use Help Function", message: "Please try again alert!")
    }
}
