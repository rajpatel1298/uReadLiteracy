//
//  DynamicVideoTableViewCell.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/13/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import WebKit

class DynamicVideoTableViewCell: UITableViewCell,WKNavigationDelegate {
    
    @IBOutlet weak var webview: WKWebView!
    var html:String!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicator.startAnimating()
        webview.navigationDelegate = self
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
