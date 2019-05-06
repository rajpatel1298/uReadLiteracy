//
//  ComprehensionPopup.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/5/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class ComprehensionPopup:UIView,UITextViewDelegate{
    fileprivate var answer = ""
    let animationDuration = TimeInterval(0.5)
    
    fileprivate let topBackgroundIV = UIImageView(frame: .zero)
    fileprivate let popupView = UIStackView(frame: .zero)
    fileprivate let popupViewBackground = UIView(frame: .zero)
    
    fileprivate let darkBackground = CALayer()
    fileprivate var questionLabel = QuestionLabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDarkGrayBackground()
        
        topBackgroundIV.image = #imageLiteral(resourceName: "book background")
        addSubview(topBackgroundIV)
        
        setupPopupView()
        popupView.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setSubviewsLocation()
    }
    
    private func setSubviewsLocation(){
        let XMid = frame.width/2
        let popupWidth = frame.width*5/6
        let YMid = frame.height/2
        let popupHeight = frame.height * 4/7
        
        let XPadding:CGFloat = 20
        let YPadding:CGFloat = 10
        
        topBackgroundIV.frame = CGRect(x: XMid-popupWidth/2, y: YMid - popupHeight/2 , width: popupWidth, height: popupHeight/2)
        
       // topBackgroundIV.contentMode = .scaleAspectFill
        darkBackground.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        
        let popViewFrame = CGRect(x: XMid-popupWidth/2 + XPadding, y: topBackgroundIV.frame.origin.y + topBackgroundIV.frame.height, width: popupWidth - XPadding*2, height: popupHeight/2)
        
        popupView.frame = popViewFrame
        
        questionLabel.frame = CGRect(x: popupView.frame.origin.x, y: popupView.frame.origin.y, width: popupView.frame.width, height: popupView.frame.height/2)
        popupView.addArrangedSubview(questionLabel)
        
        let answerBtn = AnswerButton()
        answerBtn.frame = CGRect(x: popupView.frame.origin.x, y: popupView.frame.origin.y + questionLabel.frame.height, width: popupView.frame.width, height: popupView.frame.height/2)
        
        answerBtn.addTarget(self, action: #selector(acceptBtnPressed), for: .touchDown)
        popupView.addArrangedSubview(answerBtn)
        
        addSubview(popupView)
        
        
        let popViewBackgroundFrame = CGRect(x: XMid-popupWidth/2 , y: topBackgroundIV.frame.origin.y +  topBackgroundIV.frame.height, width: popupWidth, height: popViewFrame.height + YPadding)
        
        popupViewBackground.frame = popViewBackgroundFrame
        
    }
    
    @objc fileprivate func acceptBtnPressed(sender: UIButton!) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: self.animationDuration, animations: {
                self.alpha = 0
            }, completion: { (completed) in
                if completed{
                    self.removeFromSuperview()
                }
            })
        }
    }
    
    func setQuestionText(question:String){
        questionLabel.text = question
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type Your Answer"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        answer = textView.text
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


// MARK: Setup
extension ComprehensionPopup{
    fileprivate func setupDarkGrayBackground(){
        darkBackground.frame = self.frame
        darkBackground.backgroundColor = UIColor.black.cgColor
        darkBackground.opacity = 0.5
        self.layer.addSublayer(darkBackground)
    }
    
    fileprivate func setupPopupView(){
        popupView.alignment = .fill
        popupView.distribution = .fill
        popupView.axis = .vertical
        
        popupViewBackground.backgroundColor = UIColor.white
        addSubview(popupViewBackground)
    }
}
