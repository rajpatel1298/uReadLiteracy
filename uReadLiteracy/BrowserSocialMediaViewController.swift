//
//  BrowserSocialMediaViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/14/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class BrowserSocialMediaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    @IBOutlet weak var userIV: UIImageView!
    @IBOutlet weak var userCommentTV: UITextView!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    
    
    var currentArticle:ArticleModel? {
        didSet{
            observeComments()
        }
    }
    
    private var commentList = [ArticleComment]()
    
    private var commentRef:DatabaseQuery?
    
    let currentUser = CurrentUserModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.separatorStyle = .none
        userCommentTV.delegate = self
        
        userCommentTV.text = "Type Your Commet"
        userCommentTV.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type Your Comment"
            textView.textColor = UIColor.lightGray
        }
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
        userIV.image =  currentUser.getImage()
        
    }
    
    private func observeComments(){
        if currentArticle == nil{
            fatalError()
        }
        
        let articleName = (currentArticle?.getTitle())!
        
        commentRef = Database.database().reference().child(articleName).queryOrderedByKey()
        
        commentRef!.observe(.value, with: { snapshot in
            self.commentList.removeAll()
    
            let snapshotDic = snapshot.value as? [String:Any]
            
            if snapshotDic == nil{
                return
            }
            
            for (key,value) in snapshotDic! {
                let commentUid = key
                
                let dict = value as! [String:[String:String]]
                
                for (dateAsString,commentDetail) in dict{
                    let commentString = commentDetail["comment"]
                    let username = commentDetail["username"]
                    
                    let comment = ArticleComment(articleName: (self.currentArticle?.getTitle())!, uid: commentUid, username: username!, comment: commentString!, date: Date.get(string: dateAsString))
                    
                    self.commentList.append(comment)
                }
            }
            
            self.commentList.sort(by: { (c1, c2) -> Bool in
                return c1.date! > c2.date!
            })
            
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
            
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if commentRef != nil{
            commentRef!.removeAllObservers()
        }
    }
    
    @IBAction func postBtnPressed(_ sender: Any) {
        if (currentArticle != nil){
            let comment = ArticleComment(articleName: (currentArticle?.getTitle())!, uid: currentUser.getUid(), username: currentUser.getNickname(), comment: userCommentTV.text)
            comment.uploadToFirebase()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "SocialMediaUserCell") as! SocialMediaUserCell
        
        let comment = commentList[indexPath.row]
        if comment.userImage == nil{
            comment.getImage { (image) in
                comment.userImage = image
                DispatchQueue.main.async {
                    cell.imageview.image = image
                }
                
            }
        }
        else{
            cell.imageview.image = comment.userImage
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let comment = commentList[indexPath.row]
        
        let cell = cell as! SocialMediaUserCell
        cell.commentLabel.text = comment.comment
        cell.commentLabel.font = UIFont(name: "NokioSans-Medium", size: 14)
        
        cell.commentLabel.layer.cornerRadius = 10
        cell.commentLabel.layer.masksToBounds = false
        cell.commentLabel.clipsToBounds = true
        
        cell.imageview.layer.cornerRadius = 10
        cell.imageview.layer.masksToBounds = false
        cell.imageview.clipsToBounds = true
        
        cell.dateLabel.text = comment.date?.toString()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let comment = commentList[indexPath.row]
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "SocialMediaUserCell") as! SocialMediaUserCell
        cell.commentLabel.text = comment.comment
        cell.commentLabel.numberOfLines = 0
        cell.commentLabel.font = UIFont(name: "NokioSans-Medium", size: 14)
        
        let fixedWidth = cell.commentLabel.frame.size.width * 2

        let newSize: CGSize = cell.commentLabel.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))

        if newSize.height < 70 {
            return 55 + newSize.height
        }
        
        return newSize.height + 40
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
