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
    private var childWebPageForSegue:ChildWebPage!
    
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
                self.childWebPageForSegue = childWebPage
                self.performSegue(withIdentifier: "BrowserToBrowserWithPlayerSegue", sender: self)
            }
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BrowserWithPlayerViewController{
            destination.childWebPage = childWebPageForSegue
        }
    }
    

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
