//
//  DictionaryWebViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/2/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import WebKit

class DictionaryWebViewController: UIViewController {
    
    @IBOutlet weak var webview: WKWebView!
    
    var url:URL!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview.load(URLRequest(url: url))

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
