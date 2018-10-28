//
//  WebPage.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 10/23/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import SwiftSoup

class ParentWebPage{
    internal var urlString:String
    private var htmlString:String?
    private var url:URL?
    
    init(urlString:String){
        self.urlString = urlString
    }
    
    func getUrlAsString()->String{
        return urlString
    }
    
    func getAttributedTextFromURL()->NSAttributedString{
        getURL()
        
        do {
            htmlString = try String(contentsOf: url!, encoding: .ascii)

            return htmlString!.convertHtml()
        } catch let error {
            print("Error: \(error)")
            return "".convertHtml()
        }
    }
    
    func getHtmlString()->String?{
        return htmlString
    }
    
    
    
    private func getURL(){
        guard let myURL = URL(string: urlString) else {
            print("Error: \(urlString) doesn't seem to be a valid URL")
            return
        }
        url = myURL
    }
}
