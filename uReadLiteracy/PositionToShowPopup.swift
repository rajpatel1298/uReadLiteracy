//
//  ComprehensionPopupShowPoint.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/9/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class PositionToShowPopup{
    var y:CGFloat
    private var shown:Bool!
    
    init(y:CGFloat){
        self.y = y
        shown = false
    }
    
    func showPopup(){
        shown = true
    }
    
    func isShowing()->Bool{
        return shown
    }
    
    func reset(){
        shown = false
    }
}
