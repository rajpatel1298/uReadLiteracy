//
//  BrowserController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/20/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import Foundation
import WebKit

class BrowserController{
    private var webView: WKWebView!
    
    var currentArticle:ArticleModel! {
        didSet{
            articleReadingTimer = ArticleReadingTimer(timerOn: currentArticle)
            currentArticle.incrementReadCount()
            articleReadingTimer.startRecordingTime()
        }
    }
    
    var articleReadingTimer :ArticleReadingTimer!
    
    init(webView:WKWebView, url:String, vc:BrowseViewController){
        self.webView = webView
    }
    
    
    
    
    
    
}
