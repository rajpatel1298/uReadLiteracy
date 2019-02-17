//
//  ComprehensionPopupShowPoint.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/9/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class ComprehensionPopupModel{
    private var popupLocation:PopupLocation
    var question:String
    var shown:Bool!
    
    init(popupLocation:PopupLocation, question:String){
        self.popupLocation = popupLocation
        self.question = question
        shown = false
    }
    
    func isShowing()->Bool{
        return shown
    }
    
    func resetShowingStatus(){
        shown = false
    }
    
    func getYPosition(maxOffset:CGFloat)->CGFloat{
        switch(popupLocation){
        case .Top:
            return maxOffset*10/100
        case .MiddleTop:
            return maxOffset*30/100
        case .Middle:
            return maxOffset*1/2
        case .MiddleBottom:
            return maxOffset*70/100
        case .Bottom:
            return maxOffset*90/100
        }
    }
}
