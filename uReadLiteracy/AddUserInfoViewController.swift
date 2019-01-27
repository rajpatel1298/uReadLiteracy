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
    @IBOutlet weak var nicknameTF: UITextField!
    @IBOutlet weak var userImageOutsideView: UIView!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    private var noNickanmeAlert:InfoAlert!
    private var imageSelected = false
    private var animatedRectangle:AnimatedRectangle!
    
    var loadingScreen = ActivityIndicatorWithDarkBackground()

    override func viewDidLoad() {
        super.viewDidLoad()
        noNickanmeAlert = InfoAlert(viewcontroller: self, title: "Please Add Your Nickname", message: "")
        
        nextBtn.layer.cornerRadius = 5
        nextBtn.layer.masksToBounds = false
        nextBtn.clipsToBounds = true
        
        animatedRectangle = AnimatedRectangle(topLeft: CGPoint(x: userIV.frame.origin.x, y: userIV.frame.origin.y), width: userIV.frame.width, height: userIV.frame.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(imageSelected){
            userIV.layer.removeAllAnimations()
        }
        else{
            animateUserIV()
        }
        loadingScreen.removeFromSuperview()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatedRectangle.animate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        animatedRectangle.removeFromSuperlayer()
        animatedRectangle.resetPath(topLeft: CGPoint(x: userIV.frame.origin.x, y: userIV.frame.origin.y), width: userIV.frame.width, height: userIV.frame.height)
        userImageOutsideView.layer.addSublayer(animatedRectangle)
        loadingScreen.frame = view.frame
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        userIV.layer.removeAllAnimations()
    }
    
    func animateUserIV(){
        self.userIV.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [.autoreverse,.repeat], animations: {
            self.userIV.alpha = 0.5
        }, completion: nil)
    }
    
    func startLoading(){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                self.view.addSubview(self.loadingScreen)
            }
        }
    }
    
    func stopLoading(){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                for v in self.view.subviews{
                    if v is ActivityIndicatorWithDarkBackground{
                        v.removeFromSuperview()
                    }
                }
            }
        }
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
        userIV.alpha = 1
        
        stopLoading()
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        startLoading()
        
        if(allInfoIsFilled()){
            var image:UIImage?
            if(imageSelected){
                image = userIV.image!
            }
            
            let currentUser = UserModel()
      
            currentUser.createUser(image: image, nickname: nicknameTF.text!) { (state) in
                
                DispatchQueue.main.async {
                    self.stopLoading()
                    
                    switch(state){
                    case .Success:
                        self.performSegue(withIdentifier: "AddUserInfoToWalkthroughSegue", sender: self)
                        break
                    case .Failure(let err):
                        fatalError("Handle err")
                        break
                    default:
                        break
                    }
                }
                
            }
        }
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
