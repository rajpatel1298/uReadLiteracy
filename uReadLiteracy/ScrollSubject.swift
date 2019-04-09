//
//  Subject.swift
//  TimBanCu
//
//  Created by Duy Le 2 on 2/3/19.
//  Copyright © 2019 Duy Le 2. All rights reserved.
//

import Foundation
import UIKit

class ScrollSubject{
    private var observers = [ScrollObserver]()
    
    init(){
        
    }
    
    func attach(observer:ScrollObserver){
        observers.append(observer)
    }
    
    func detachAll(){
        observers.removeAll()
    }
    

    
    func notify(with yPosition:CGFloat, view:UIView){
        for ob in observers{
            ob.onScrolled(view: view, yPosition: yPosition)
        }
    }
    
}
