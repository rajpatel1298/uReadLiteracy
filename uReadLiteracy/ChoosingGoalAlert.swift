//
//  ChoosingGoalAlert.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/24/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class ChoosingGoalAlert{
    private var alert:UIAlertController!
    let viewcontroller:UIViewController
    
    
    init(viewcontroller:UIViewController, completionHandler:@escaping ()->()){
        self.viewcontroller = viewcontroller
        
        alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        setupAlert(completionHandler: completionHandler)
    }
    
    init(viewcontroller:UIViewController,title:String,message:String, completionHandler:@escaping ()->()){
        self.viewcontroller = viewcontroller
        
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        setupAlert(completionHandler: completionHandler)
    }
    
    func setupAlert(completionHandler:@escaping ()->()){
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            DispatchQueue.main.async {
                self.alert.dismiss(animated: true, completion: nil)
                completionHandler()
            }
        }))
    }
    
    func setMessage(message:String){
        alert.message = message
    }
    
    func setTitle(title:String){
        alert.title = title
    }
    
    func show(){
        viewcontroller.present(alert, animated: true, completion: nil)
    }
}
