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
    
    
    fileprivate var onAccept:((_ answer:String)->Void)?
    fileprivate var onSkip:(()->Void)?
    
    fileprivate var answer = ""
    let animationDuration = TimeInterval(0.5)
    
    fileprivate let topBackgroundIV = UIImageView(frame: .zero)
    fileprivate let popupView = UIStackView(frame: .zero)
    fileprivate let popupViewBackground = UIView(frame: .zero)
    
    fileprivate let darkBackground = CALayer()
    fileprivate var questionLabel:QuestionLabel!
    
    private var questionsList = ["Is this fiction (made up) or non-fiction (true, facts)?",
                                 "What’s interesting to me about this?  Why do I want to read it?",
                                  "What do I notice about the text before I even start to read?"]
    
    
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
        
        topBackgroundIV.frame = CGRect(x: XMid-popupWidth/2, y: YMid - popupHeight/2 , width: popupWidth, height: popupHeight*2/5)
        
       // topBackgroundIV.contentMode = .scaleAspectFill
        darkBackground.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        
        let popViewFrame = CGRect(x: XMid-popupWidth/2 + XPadding, y: topBackgroundIV.frame.origin.y + topBackgroundIV.frame.height, width: popupWidth - XPadding*2, height: popupHeight*2/3)
        
        popupView.frame = popViewFrame
        
        
        let popViewBackgroundFrame = CGRect(x: XMid-popupWidth/2 , y: topBackgroundIV.frame.origin.y +  topBackgroundIV.frame.height, width: popupWidth, height: popupHeight*3/5 + YPadding)
        
        popupViewBackground.frame = popViewBackgroundFrame
        
    }
    
    @objc fileprivate func acceptBtnPressed(sender: UIButton!) {
        if onAccept == nil{
            fatalError("Did not call setupClosure")
        }
        else{
            onAccept!(answer)
        }
    }
    
    @objc fileprivate func skipBtnPressed(sender: UIButton!) {
        if onSkip == nil{
            fatalError("Did not call setupClosure")
        }
        else{
            onSkip!()
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
        self.onAccept = {(_)->Void in }
        self.onSkip = {}
        super.init(coder: aDecoder)
    }
    
}


// MARK: Setup
extension ComprehensionPopup{
    func setupClosure(onAccept:@escaping (_ answer:String)->Void, onSkip:@escaping ()->Void){
        self.onAccept = onAccept
        self.onSkip = onSkip
    }
    
    fileprivate func setupDarkGrayBackground(){
        darkBackground.frame = self.frame
        darkBackground.backgroundColor = UIColor.black.cgColor
        darkBackground.opacity = 0.5
        self.layer.addSublayer(darkBackground)
    }
    
    fileprivate func setupPopupView(){
        popupView.alignment = .fill
        popupView.distribution = .
        popupView.axis = .vertical
        popupView.spacing = 10
        
        popupViewBackground.backgroundColor = UIColor.white
        addSubview(popupViewBackground)
        
        questionLabel = QuestionLabel()
        questionLabel.text = "No Question Available"
        popupView.addArrangedSubview(questionLabel)
        
        let responseTV = ResponseTextView()
        responseTV.delegate = self
        popupView.addArrangedSubview(responseTV)
        
        let optionView = getOptionView()
        popupView.addArrangedSubview(optionView)
        
        let skipBtn = SkipButton()
        skipBtn.addTarget(self, action: #selector(skipBtnPressed), for: .touchDown)
        optionView.addArrangedSubview(skipBtn)
        
        let answerBtn = AnswerButton()
        answerBtn.addTarget(self, action: #selector(acceptBtnPressed), for: .touchDown)
        optionView.addArrangedSubview(answerBtn)
        
        let dashedBorder = CAShapeLayer()
        dashedBorder.strokeColor = UIColor.black.cgColor
        dashedBorder.lineDashPattern = [8, 4]
        dashedBorder.lineWidth = 1
        dashedBorder.frame = responseTV.bounds
        
        dashedBorder.fillColor = nil
        dashedBorder.path = UIBezierPath(rect: responseTV.frame).cgPath
        popupView.layer.addSublayer(dashedBorder)
        
        addSubview(popupView)
    }

    private func getOptionView()->UIStackView{
        let optionView = UIStackView(frame: .zero)
        optionView.alignment = .center
        optionView.distribution = .fillEqually
        optionView.axis = .horizontal
        optionView.spacing = 10
        return optionView
    }
}
