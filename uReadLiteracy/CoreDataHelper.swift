//
//  CoreDataHelper.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/8/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper{
    static var sharedInstance = CoreDataHelper()
    
    private var appDelegate:AppDelegate!
    
    init(){
        setup()
    }
    
    private func setup(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
    }
    
    func getManagedContext()->NSManagedObjectContext{
        let managedContext = appDelegate.persistentContainer.viewContext
        return managedContext
    }
    
    
    
    
}
