//
//  CoreDataModelHandler.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/27/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataModelHandler{
    private var appDelegate:AppDelegate!
    let managedContext:NSManagedObjectContext
    static let shared = CoreDataModelHandler()
    
    init(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func getList()->[Any]{
        fatalError("Need to be implement")
    }
    
    func save(){
        fatalError("Need to be implement")
    }
}
