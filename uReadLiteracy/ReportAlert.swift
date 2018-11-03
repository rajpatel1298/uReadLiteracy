//
//  ReportAlert.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/2/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class ReportAlert{
    private var alert:UIAlertController!
    let viewcontroller:UIViewController
    
    init(viewcontroller:UIViewController,title:String,message:String){
        self.viewcontroller = viewcontroller
        
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Report", style: .default, handler: { (_) in
            // do report stuffs
        }))
    }
    
    func show(){
        viewcontroller.present(alert, animated: true, completion: nil)
    }
}
