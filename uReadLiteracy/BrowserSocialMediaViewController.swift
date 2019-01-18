//
//  BrowserSocialMediaViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/14/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit
import FirebaseAuth

class BrowserSocialMediaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    @IBOutlet weak var userIV: UIImageView!
    @IBOutlet weak var userCommentTV: UITextView!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    var currentArticle:ArticleModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUserCommentTV()
        setupUserIV()
    }
    
    private func setupUserIV(){
        userIV.layer.cornerRadius = userIV.frame.width/2
        userIV.layer.masksToBounds = false
        userIV.clipsToBounds = true
    }
    
    private func setupUserCommentTV(){
        userCommentTV.layer.cornerRadius = 10
        userCommentTV.layer.masksToBounds = false
        userCommentTV.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userIV.image =  UserModel.sharedInstance.getImage()
    }
    
    @IBAction func postBtnPressed(_ sender: Any) {
        if (currentArticle != nil){
            //let comment = SocialMediaComment(articleName: (currentArticle?.getName())!, uid: UserModel.sharedInstance., username: <#T##String#>, comment: <#T##String#>)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
