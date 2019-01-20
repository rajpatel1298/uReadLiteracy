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
    
    private var popupView: UIStackView!
    private var onAccept:((_ answer:String)->Void)?
    private var onSkip:(()->Void)?
    
    private var answer = ""
    let animationDuration = TimeInterval(0.5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDarkGrayBackground()
        setupPopupView()
    }
    
    func setupClosure(onAccept:@escaping (_ answer:String)->Void, onSkip:@escaping ()->Void){
        self.onAccept = onAccept
        self.onSkip = onSkip
    }
    
    
    private func setupDarkGrayBackground(){
        let darkBackground = CALayer()
        darkBackground.frame = self.frame
        darkBackground.backgroundColor = UIColor.black.cgColor
        darkBackground.opacity = 0.5
        self.layer.addSublayer(darkBackground)
    }
    
    private func setupPopupView(){
        let XMid = frame.width/2
        let popupWidth = frame.width*5/6
        let YMid = frame.height/2
        let popupHeight = frame.height * 4/7
        
        let XPadding:CGFloat = 20
        let YPadding:CGFloat = 10
        
        let topBackgroundIV = UIImageView(frame: CGRect(x: XMid-popupWidth/2, y: YMid - popupHeight/2 , width: popupWidth, height: popupHeight*2/5))
        topBackgroundIV.image = #imageLiteral(resourceName: "book background")
       // topBackgroundIV.contentMode = .scaleAspectFill
        self.addSubview(topBackgroundIV)
        
        
        let popViewFrame = CGRect(x: XMid-popupWidth/2 + XPadding, y: topBackgroundIV.frame.origin.y + topBackgroundIV.frame.height, width: popupWidth - XPadding*2, height: popupHeight*2/3)
        let popViewBackgroundFrame = CGRect(x: XMid-popupWidth/2 , y: topBackgroundIV.frame.origin.y +  topBackgroundIV.frame.height, width: popupWidth, height: popupHeight*3/5 + YPadding)
        
        popupView = UIStackView(frame: popViewFrame)
        popupView.alignment = .fill
        popupView.distribution = .fillEqually
        popupView.axis = .vertical
        popupView.spacing = 10
        
      
        
        let questionLabel = UILabel(frame: .zero)
        questionLabel.text = "Question: What is the meaning of life?"
        questionLabel.font = UIFont(name: "NokioSansAlt-Medium", size: 23)
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 3
        popupView.addArrangedSubview(questionLabel)
        
        let responseTV = UITextView(frame: .zero)
        responseTV.text = "Type Your Answer"
        responseTV.textColor = UIColor.lightGray
        responseTV.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        responseTV.isEditable = true
        responseTV.delegate = self
        
        popupView.addArrangedSubview(responseTV)
        
        let optionView = UIStackView(frame: .zero)
        optionView.alignment = .center
        optionView.distribution = .fillEqually
        optionView.axis = .horizontal
        optionView.spacing = 10
        
        
        let skipBtn = UIButton(frame: .zero)
        skipBtn.setTitle("Skip", for: .normal)
        skipBtn.setTitleColor(UIColor.lightGray, for: .normal)
        skipBtn.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        skipBtn.layer.cornerRadius = 10
        skipBtn.layer.masksToBounds = true
        skipBtn.addTarget(self, action: #selector(skipBtnPressed), for: .touchDown)
        
        optionView.addArrangedSubview(skipBtn)
        popupView.addArrangedSubview(optionView)
        
        let answerBtn = UIButton(frame: .zero)
        answerBtn.setTitle("Answer", for: .normal)
        answerBtn.setTitleColor(UIColor.white, for: .normal)
        answerBtn.backgroundColor = UIColor.init(red: 255/255, green: 140/255, blue: 0/255, alpha: 1)
        answerBtn.layer.cornerRadius = 10
        answerBtn.layer.masksToBounds = true
        answerBtn.addTarget(self, action: #selector(acceptBtnPressed), for: .touchDown)
        
        optionView.addArrangedSubview(answerBtn)
        
        let popupViewBackground = UIView(frame: popViewBackgroundFrame)
        popupViewBackground.backgroundColor = UIColor.white
        self.addSubview(popupViewBackground)
        self.addSubview(popupView)
        
        
        popupView.layoutIfNeeded()
        
        let dashedBorder = CAShapeLayer()
        dashedBorder.strokeColor = UIColor.black.cgColor
        dashedBorder.lineDashPattern = [8, 4]
        dashedBorder.lineWidth = 1
        dashedBorder.frame = responseTV.bounds
        
        dashedBorder.fillColor = nil
        dashedBorder.path = UIBezierPath(rect: responseTV.frame).cgPath
        popupView.layer.addSublayer(dashedBorder)
        
    }
    
    @objc private func acceptBtnPressed(sender: UIButton!) {
        if onAccept == nil{
            fatalError("Did not call setupClosure")
        }
        else{
            onAccept!(answer)
        }
    }
    
    @objc private func skipBtnPressed(sender: UIButton!) {
        if onSkip == nil{
            fatalError("Did not call setupClosure")
        }
        else{
            onSkip!()
        }
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
        self.onAccept = {(_)->Void in }
        self.onSkip = {}
        super.init(coder: aDecoder)
    }
    
}
