//
//  AddUserImageViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 6/4/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class AddUserImageViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageview: RoundedImageView!
    @IBOutlet weak var initialLabel: UILabel!
    @IBOutlet weak var skipBtn: RoundedButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    private var imageSelected = false
    private var networkFailAlert:InfoAlert?
    private var continueToNextPage = false
    
    var nickname:String = "?"
    
    func inject(nickname:String){
        self.nickname = nickname
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        networkFailAlert = InfoAlert(viewcontroller: self, title: "Cannot Connect To Server", message: "Please Check Your Network")

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        continueToNextPage = false
        
        updateUI()
        
        let nameParts = nickname.split(separator: " ")
        var initial = ""
        for name in nameParts{
            initial = initial + (String(name.first ?? Character(""))  )
        }
        
        initialLabel.text = initial
        
        activityIndicator.stopAnimating()
    }
    
    
    @IBAction func choosePicturePressed(_ sender: Any) {
        activityIndicator.startAnimating()
        
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @IBAction func skipBtnPressed(_ sender: Any) {
        continueToNextPage = true
        nextStep()
    }
    
    private func nextStep(){
        activityIndicator.startAnimating()
        
        var image:UIImage?
        if(imageSelected){
            image = imageview.image!
        }
        
        let currentUser = CurrentUser.shared
        currentUser.nickname = nickname
        currentUser.image = image
        
        let tempId = UUID().uuidString
        currentUser.email = "\(tempId)@gmail.com"
        currentUser.password = tempId
        
        FirebaseAuthService.shared.createUser(user: currentUser) { [weak self] (state) in
            
            guard let strongself = self else{
                return
            }
            
            DispatchQueue.main.async {
                switch(state){
                case .Success:
                    strongself.activityIndicator.stopAnimating()
                    if(strongself.continueToNextPage){
                        UserDefaults.standard.set(false, forKey: "firstTime")
                        strongself.performSegue(withIdentifier: "AddUserImageToMainSegue", sender: strongself)
                    }
                    
                    break
                case .Failure(let err):
                    strongself.networkFailAlert?.show()
                    break
                default:
                    break
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        activityIndicator.stopAnimating()
        
        picker.dismiss(animated: true)
        
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        imageview.image = image
        imageSelected = true
        
        updateUI()
        nextStep()
    }
    
    private func updateUI(){
        if(imageSelected){
            initialLabel.isHidden = true
            skipBtn.setTitle("Continue", for: .normal)
        }
        else{
            initialLabel.isHidden = false
            skipBtn.setTitle("Skip", for: .normal)
        }
    }

}
