//
//  BrowserUIController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/3/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class BrowserUIController{
    //private var viewcontroller:NewBrowserViewController!
    
    private var uistate:UIState = .Loading
    private var activityIndicator:UIActivityIndicatorView!
    
    init(viewcontroller:NewBrowserViewController){
        //self.viewcontroller = viewcontroller
        self.activityIndicator = viewcontroller.activityIndicator
    }
    
    func updateUiState(newUIState:UIState){
        switch(uistate,newUIState){
        case (.Loading,.Loading):
            showLoading()
            break
        case (.Loading,.Success):
            hideLoading()
            break
        default:
            fatalError()
            break
        }
    }
    
    private func showLoading(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    private func hideLoading(){
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
