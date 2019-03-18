//
//  WebViewManager.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 3/17/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class WebViewManager{
    private let webView:WKWebviewWithHelpMenu
    
    private var oldScrollX:CGFloat = 0
    private var oldScrollY:CGFloat = 0
    private var maxOffset:Int!
    
    init(webview:WKWebviewWithHelpMenu){
        self.webView = webview
    }
    
    func scrollToCurrentCoordinate(){
        oldScrollX = webView.scrollView.contentOffset.x
        oldScrollY = webView.scrollView.contentOffset.y
        
        webView.scrollView.setContentOffset(CGPoint(x: webView.scrollView.contentOffset.x, y: webView.scrollView.contentOffset.y), animated: true)
    }
    
    func scrollToOldCoordinate(){
        webView.scrollView.setContentOffset(CGPoint(x: oldScrollX, y: oldScrollY), animated: true)
    }
    
    func setMaxOffset(){
        maxOffset = Int(webView.scrollView.contentSize.height - webView.scrollView.bounds.height + webView.scrollView.contentInset.bottom)
    }
    
    func getMaxOffset()->Int{
        return maxOffset
    }
    
}
