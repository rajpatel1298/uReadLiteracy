//
//  Observer.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 10/28/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation

protocol AudioObserver{
    var subject:AudioSubject? {get set}
    func update()
    func setSubject(subject:AudioSubject)
}
