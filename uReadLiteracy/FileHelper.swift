//
//  FileHelper.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/30/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation

class FileHelper{
    //function that gets path to directory
    static func getDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
}
