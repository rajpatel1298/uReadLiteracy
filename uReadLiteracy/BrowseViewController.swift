//
//  BrowseViewController.swift
//  uReadLiteracy
//
//  Created by Raj Patel on 1/25/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import SafariServices
import WebKit

class BrowseViewController: UIViewController, WKUIDelegate{
    
    var webView: WKWebView!
    var helpWords = [String]()
    let helpItem = UIMenuItem.init(title: "Help", action: #selector(getHelp))
   /*
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        let rect = CGRect.init(x: 0, y: -10, width: 100, height: 100)
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        webView.uiDelegate = self
        view = webView
        
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        webView = WKWebView(frame: CGRect( x: 0, y: 60, width: self.view.frame.width, height: self.view.frame.height - 60 ), configuration: WKWebViewConfiguration() )
        webView.uiDelegate = self;
        self.view.addSubview(webView)
      
        UIMenuController.shared.menuItems = [helpItem]
        UIMenuController.shared.update()
        UIMenuController.shared.setMenuVisible(true, animated: true)
        
        let url = URL(string: "http://www.manythings.org/voa/stories/")
        let request = URLRequest(url: url!)
        webView.load(request)
        if let str = UIPasteboard.general.string {
            print(str + " found in pasteboard")
        }
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getHelp(){
       
        updatePasteboard { (success) in
            if success {
                print(UIPasteboard.general.string!)
                print(UIPasteboard.general.strings!)
                var str = UIPasteboard.general.string
                str = str?.trimmingCharacters(in: .whitespacesAndNewlines)
                
                if let url = URL(string: "http://www.dictionary.com/browse/\(str ?? "hello")?s=t"){
                    let safariController = SFSafariViewController(url: url)
                    self.present(safariController, animated: true, completion: nil)
                    print(UIPasteboard.general.string! + ":before")
                    self.helpWords.append(str!)
                    print(self.helpWords)
                }
            }
            else {
                print("failure")
            }
        }
        
      //print(UIPasteboard.general.string! + ":before")
        // print(UIPasteboard.general.strings!) //copies string to the pasteboard and prints
    }
    
    func updatePasteboard(completion: @escaping (Bool) -> ()){
        var flag = true
        
       
        webView.evaluateJavaScript("window.getSelection().toString()", completionHandler: {
            (html: Any?, error: Error?) in
            print(html!)
            if let str = html as? String {
                print("first \(str)")
                UIPasteboard.general.string = str
                completion(flag)

            } else {
                print("it is not casting")
            }
            
            
        })
 
       
        if(UIPasteboard.general.string == nil){
            flag = false
        }
        //completion(flag)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "learnSegue" {
            let destinationController = segue.destination as! LearnViewController
            destinationController.helpList = helpWords
        }
    }
 

}
