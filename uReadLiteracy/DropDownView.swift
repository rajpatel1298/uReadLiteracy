//
//  DropDownView.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 4/25/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit

class DropDownView: UIView {
    
    private let decorativeView = UIView(frame: .zero)
    private let dropDownIV = UIImageView(image: #imageLiteral(resourceName: "dropdown"))
    private let titleLabel = UILabel(frame: .zero)
    private let backgroundView = UIView(frame: .zero)
    
    private let decorativeViewWidth:CGFloat = 5
    private let trailingSpace:CGFloat = 10
    private var dropDownIVHeight:CGFloat = 0
    
    private var tapGesture:UITapGestureRecognizer!
    private let expanded:Bool
    private let title:String
    
    private let delegate: DropDownDelegate?
    
    init(title:String, expanded:Bool,frame:CGRect, delegate:DropDownDelegate){
        self.delegate = delegate
        self.title = title
        self.expanded = expanded
        super.init(frame: frame)
        titleLabel.text = title
        self.addSubview(decorativeView)
        self.addSubview(dropDownIV)
        self.addSubview(titleLabel)
        self.addSubview(backgroundView)
        self.sendSubview(toBack: backgroundView)
     
        rotateDropDownIV()
        
        self.backgroundColor = UIColor.white
        
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.02
        
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(onViewTapped(sender:)))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.delegate = nil
        self.title = ""
        self.expanded = false
        super.init(coder: aDecoder)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(onViewTapped(sender:)))
    }
    
    override func layoutSubviews() {
        
        dropDownIVHeight = frame.height/4
        setupDecorativeView()
        setupDropDownIV()
        setupTitleLabel()
        
        super.layoutSubviews()
        
        rotateDropDownIV()
    }
    
    @objc private func onViewTapped(sender:UIGestureRecognizer){
        delegate?.dropDownChanged(dropDownTitle: title)
    }
    
    private func rotateDropDownIV(){
        if(expanded){
            UIView.animate(withDuration: 0.5) {
                self.dropDownIV.transform = CGAffineTransform.identity
                self.layoutIfNeeded()
            }
        }
        else{
            UIView.animate(withDuration: 0.5) {
                self.dropDownIV.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                self.layoutIfNeeded()
            }
        }
    }
    
    private func setupDecorativeView(){
        decorativeView.frame = CGRect(x: 0, y: frame.height/10, width: decorativeViewWidth, height: frame.height*8/10)
        decorativeView.backgroundColor = UIColor.orange
    }
    
    private func setupTitleLabel(){
        let x = decorativeViewWidth + 5
        let width:CGFloat = frame.width - x - trailingSpace - dropDownIVHeight - trailingSpace
        titleLabel.frame = CGRect(x: x, y: 0, width: width, height: frame.height)
        titleLabel.font = UIFont(name: "NokioSans-Bold", size: 25)
    }
    
    private func setupDropDownIV(){
        let y = frame.height/2 - dropDownIVHeight/2
        let x = frame.width - dropDownIVHeight - trailingSpace
        dropDownIV.frame = CGRect(x: x, y: y, width: dropDownIVHeight, height: dropDownIVHeight)
    }
    
}
