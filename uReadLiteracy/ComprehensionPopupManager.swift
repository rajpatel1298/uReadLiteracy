//
//  ComprehensionPopupManager.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/9/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class ComprehensionPopupManager{
    private var maxYOffset:CGFloat!
    private var showAtYOffsets:[ComprehensionPopupShowPoint]!
    
    init(){
        showAtYOffsets = [ComprehensionPopupShowPoint]()
        maxYOffset = 0
    }
    
    func shouldShowPopup(currentYOffset:CGFloat)->Bool{
        if maxYOffset == 0{
            return false
        }
        
        for position in showAtYOffsets{
            if  position.y.isLessThanOrEqualTo(currentYOffset) && currentYOffset.isLessThanOrEqualTo(position.y + maxYOffset/100*5)  && !position.isShowing(){
                position.showPopup()
                return true
            }
        }
        return false
    }
    
    func setYOffsetsToShowPopup(showAtYOffsets:[ComprehensionPopupShowPoint]){
        self.showAtYOffsets = showAtYOffsets
    }
    
    func setMaxYOffset(value:CGFloat){
        maxYOffset = value
    }
    
    func reset(){
        for position in showAtYOffsets{
            position.reset()
        }
    }
}
