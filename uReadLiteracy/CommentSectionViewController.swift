//
//  CommentSectionViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 1/14/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Lottie

class CommentSectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
   
    @IBOutlet weak var userCommentTV: RoundedTextView!
    @IBOutlet weak var postBtn: RoundedButton!
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var emptyAnimationView: AnimationView!
    

    private var currentArticle:ArticleModel!
    
    private var commentList = [ArticleComment]()
    
    private var commentRef:DatabaseQuery?
    
    let currentUser = CurrentUser.shared
    
    private var isShowing = false
    
    private let firebaseObserver = FirebaseObserver()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.separatorStyle = .none
        userCommentTV.delegate = self
        
        userCommentTV.text = "Type Your Comment"
        userCommentTV.textColor = UIColor.lightGray
        
        emptyAnimationView.loopMode = .loop
    }
    
    func inject(currentArticle:ArticleModel){
        self.currentArticle = currentArticle
        didSetCurrentArticle()
    }
    
    private func didSetCurrentArticle(){        
        let articleName = currentArticle.name
        
        firebaseObserver.observeComment(articleName: articleName) {[weak self] (list) in
            guard let strongself = self else{
                return
            }
            
            DispatchQueue.main.async {
                strongself.commentList = list
                strongself.tableview.reloadData()
                
                if(list.count == 0){
                    strongself.tableview.isHidden = true
                    strongself.emptyAnimationView.isHidden = false
                    strongself.emptyAnimationView.play()
                    
                }
                else{
                    strongself.tableview.isHidden = false
                    strongself.emptyAnimationView.isHidden = true
                    strongself.emptyAnimationView.stop()
                }
            }
        }
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
    }
    
    
    private func setupUserCommentTV(){
        userCommentTV.layer.cornerRadius = 10
        userCommentTV.layer.masksToBounds = false
        userCommentTV.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if commentRef != nil{
            commentRef!.removeAllObservers()
        }
    }
    
    @IBAction func postBtnPressed(_ sender: Any) {
        if (currentArticle != nil){
            let comment = ArticleComment(articleName: currentArticle.name, uid: currentUser.getUid(), username: currentUser.getNickname(), comment: userCommentTV.text)
            FirebaseUploader.shared.upload(comment: comment)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "SocialMediaUserCell") as! SocialMediaUserCell
        
        let comment = commentList[indexPath.row]
        if comment.userImage == nil{
            FirebaseDownloader.shared.getImage(fromComment: comment) { (image) in
                comment.userImage = image
                DispatchQueue.main.async {
                    if(image == nil){
                        cell.imageview.image = #imageLiteral(resourceName: "bluecircle")
                    }
                    else{
                        cell.imageview.image = image
                    }
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
