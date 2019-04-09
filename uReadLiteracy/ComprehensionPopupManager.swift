//
//  ComprehensionPopupManager.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/9/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class ComprehensionPopupManager:ScrollObserver{
    
    
    
    
    private var maxYOffset:CGFloat!
    private var popupModels:[ComprehensionPopupModel]!
    
    // only one popup should be created, since only one will be shown at a time
    private var popup = ComprehensionPopup()
    
    func onScrolled(view: UIView, yPosition: CGFloat) {
        updateScrollPosition(position: yPosition, popupToAddToView: { [weak self] (popup) in
            
            guard let strongself = self else{
                return
            }
            DispatchQueue.main.async {
                popup.frame = view.frame
                popup.alpha = 0
                view.addSubview(popup)
                view.layoutIfNeeded()
                
                UIView.animate(withDuration: popup.animationDuration) {
                    strongself.popup.alpha = 1
                }
            }
        })
        
        
    }
  
  
    init(popupModels:[ComprehensionPopupModel]){
        self.popupModels = popupModels
        maxYOffset = 1
        
        popup.setupClosure(onAccept: { (answer) in
            print("answer for now: \(answer)")
        }, onSkip: {
            DispatchQueue.main.async {
                UIView.animate(withDuration: self.popup.animationDuration, animations: {
                    self.popup.alpha = 0
                }, completion: { (completed) in
                    if completed{
                        self.popup.removeFromSuperview()
                    }
                })
            }
        })
    }
    
    func isPopupShowing()->Bool{
        return popup.superview != nil
    }
    
    
    private func getModelIfShouldShowPopup(currentYOffset:CGFloat)->ComprehensionPopupModel?{
        if maxYOffset == 0{
            return nil
        }
        
        for model in popupModels{
            let y = model.getYPosition(maxOffset: maxYOffset)
            
            if  y.isLessThanOrEqualTo(currentYOffset) && currentYOffset.isLessThanOrEqualTo(y + maxYOffset/100*5)  && !model.isShowing(){
                model.shown = true
                return model
            }
        }
        return nil
    }
    
    func resetPopupShownStatus(){
        for model in popupModels{
            model.resetShowingStatus()
        }
        popup.removeFromSuperview()
    }
    
    func setMaxYOffset(newValue:CGFloat){
        maxYOffset = newValue
    }
    
    // show popup if needed
    func updateScrollPosition(position: CGFloat, popupToAddToView:(_ popup:ComprehensionPopup)->Void) {
        
        let model = getModelIfShouldShowPopup(currentYOffset: position)
        if model != nil{
            DispatchQueue.main.async {
                self.popup.setQuestionText(question: (model?.question)!)
            }
            
            popupToAddToView(popup)
        }
    }
}
