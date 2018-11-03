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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    private var childWebPageForSegue:ChildWebPage!
    
    
    
    let parentWebPage = ParentWebPage(urlString: "http://www.manythings.org/voa/stories/")
    
    private var uicontroller:BrowserUIController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        uicontroller = BrowserUIController(viewcontroller: self)
        uicontroller.updateUiState(newUIState: .Loading)
        textview.attributedText = parentWebPage.getAttributedTextFromURL()
        textview.delegate = self
        uicontroller.updateUiState(newUIState: .Success)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        uicontroller.updateUiState(newUIState: .Success)
    }
    
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print(textAttachment)
        
        return true
    }
    
    
    func textView(_ textView: UITextView, shouldInteractWith myURL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        let childWebPage = ChildWebPage(urlString: myURL.absoluteString, parentUrlString: parentWebPage.getUrlAsString())
        if(AllowedPage.check(url: childWebPage.urlString)){
            uicontroller.updateUiState(newUIState: .Loading)
            
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
