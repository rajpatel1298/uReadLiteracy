//
//  WKWebviewWithHelpMenu.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/2/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import WebKit

class WKWebviewWithHelpMenu:WKWebView{
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
