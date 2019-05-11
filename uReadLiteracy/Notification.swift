//
//  Notification.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 5/10/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class NotificationManager{
    // LearnWordViewController
    private let helpWordsUpdated = Notification.Name("HelpWordsUpdated")
    
    static let shared = NotificationManager()
    
    func notifyHelpWordsUpdated(){
        NotificationCenter.default.post(Notification(name: helpWordsUpdated))
    }
    
    func observeHelpWordsUpdated(observer:Any,selector:Selector){
        NotificationCenter.default.addObserver(observer, selector: selector, name: helpWordsUpdated, object: nil)
    }
    
    func removeObserver(observer:Any){
        NotificationCenter.default.removeObserver(observer)
    }
    
    
}
