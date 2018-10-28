//
//  TestViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 10/22/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import SwiftSoup

class NewBrowserViewController: UIViewController,UITextViewDelegate {
    
    @IBOutlet weak var textview: UITextView!
    
    let parentWebPage = ParentWebPage(urlString: "http://www.manythings.org/voa/stories/")

    override func viewDidLoad() {
        super.viewDidLoad()
        textview.attributedText = parentWebPage.getAttributedTextFromURL()
        textview.delegate = self
    }
    
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print(textAttachment)
        
        return true
    }
    
    
    func textView(_ textView: UITextView, shouldInteractWith myURL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        let childWebPage = ChildWebPage(urlString: myURL.absoluteString, parentUrlString: parentWebPage.getUrlAsString())
        if(AllowedPage.check(url: childWebPage.urlString)){
            DispatchQueue.main.async {
                textView.attributedText = nil
                self.textview.attributedText = childWebPage.getAttributedTextFromURL()
                
                let str = childWebPage.getHtmlString()!
                
                if(str == nil){
                    return
                }
                
                
                do {
            
                    
                    let doc: Document = try SwiftSoup.parse(str)
                    for link in try doc.select("a"){
                        if(try link.text().count < 4){
                            continue
                        }
                        if(try link.text().suffix(4).lowercased() == ".mp3"){
                            print()
                        }
                        print(try link.text())
                    }
                } catch let error {
                    print("Error: \(error)")
                }
            }
        }
        return false
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


extension String{
    func convertHtml() -> NSAttributedString{
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do{
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        }catch{
            return NSAttributedString()
        }
    }
}
