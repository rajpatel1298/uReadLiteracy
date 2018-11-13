//
//  AddUserInfoViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/5/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import FirebaseAuth


class AddUserInfoViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var userIV: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var nicknameTF: UITextField!
    
    private var noNickanmeAlert:InfoAlert!
    private var imageSelected = false
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        noNickanmeAlert = InfoAlert(viewcontroller: self, title: "Please Add Your Nickname", message: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(imageSelected){
            userIV.layer.removeAllAnimations()
        }
        else{
            animateUserIV()
        }
        
        stopLoading()
    }
    
    func animateUserIV(){
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [.autoreverse,.repeat], animations: {
            self.userIV.alpha = 0.5
        }, completion: nil)
    }
    
    func startLoading(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopLoading(){
        activityIndicator.isHidden = true
        activityIndicator.startAnimating()
    }
    
    @IBAction func imageTapped(_ sender: Any) {
        startLoading()
        
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        userIV.image = image
        
        imageSelected = true
        
        userIV.layer.cornerRadius = userIV.frame.width/2
        userIV.layer.masksToBounds = false
        userIV.clipsToBounds = true
        userIV.alpha = 1
        
        stopLoading()
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        
        if(allInfoIsFilled()){
            if(imageSelected){
                CoreDataHelper.sharedInstance.saveUserFirstTimeInfo(image: userIV.image!, nickname: nicknameTF.text!)
            }
            else{
                CoreDataHelper.sharedInstance.saveUserFirstTimeInfo(image: #imageLiteral(resourceName: "profile"), nickname: nicknameTF.text!)
            }
        }
        
        
        
        /*let uuid = UUID().uuidString
        let email = "\(uuid)@gmail.com"
        let password = UUID().uuidString
        
        Auth.auth().createUser(withEmail: email, password: password) { (_, err) in
            
            DispatchQueue.main.async {
                CoreDataHelper.sharedInstance.saveLoginInfo(email: email, password: password)
                
                self.performSegue(withIdentifier: "AddUserInfoToWalkthroughSegue", sender: self)
            }
            
        }*/
    }
    
    func allInfoIsFilled()->Bool{
        if(!(nicknameTF.text?.isEmpty)!){
            return true
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
