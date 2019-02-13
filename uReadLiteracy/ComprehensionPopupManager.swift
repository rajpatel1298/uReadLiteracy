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
    private var positionToShowPopup:[PositionToShowPopup]!
    private let popup:ComprehensionPopup
    private var didShowPopup:()->Void
  
    init(popup:ComprehensionPopup, didShowPopup:@escaping ()->Void){
        positionToShowPopup = [PositionToShowPopup]()
        maxYOffset = 1
        self.popup = popup
        self.didShowPopup = didShowPopup
        
        popup.setupClosure(onAccept: { (answer) in
            print("answer for now: \(answer)")
        }, onSkip: {
            DispatchQueue.main.async {
                UIView.animate(withDuration: self.popup.animationDuration, animations: {
                    self.popup.alpha = 0
                }, completion: { (_) in
                    guard let superview = self.popup.superview else{
                        return
                    }
                    self.popup.isHidden = true
                    superview.sendSubview(toBack: self.popup)
                })
            }
        })
        
        // Change this to show popup at different parts of the screen
        let position1 = PositionToShowPopup(y: CGFloat(maxYOffset)/2)
        positionToShowPopup.append(position1)
    }
    
    
    func shouldShowPopup(currentYOffset:CGFloat)->Bool{
        if maxYOffset == 0{
            return false
        }
        
        for position in positionToShowPopup{
            if  position.y.isLessThanOrEqualTo(currentYOffset) && currentYOffset.isLessThanOrEqualTo(position.y + maxYOffset/100*5)  && !position.isShowing(){
                position.showPopup()
                return true
            }
        }
        return false
    }
    
    func setMaxYOffset(newValue:CGFloat){
        let oldValue = maxYOffset
        maxYOffset = newValue
        updatePositionToShowPopup(oldValue: oldValue!, newValue: newValue)
    }
    
    private func updatePositionToShowPopup(oldValue:CGFloat,newValue:CGFloat){
        for position in positionToShowPopup{
            position.y = newValue*position.y/oldValue
        }
    }
    
    func reset(){
        for position in positionToShowPopup{
            position.reset()
        }
    }
    
    // show popup if needed
    func updateScrollPosition(position: CGFloat) {
        if shouldShowPopup(currentYOffset: position){
            popup.isHidden = false
            popup.alpha = 0
            guard let superview = self.popup.superview else{
                return
            }
            superview.bringSubview(toFront: popup)
            didShowPopup()
            UIView.animate(withDuration: popup.animationDuration) {
                self.popup.alpha = 1
            }
        }
    }
}
