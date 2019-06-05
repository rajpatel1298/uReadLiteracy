//
//  AddUserInfoViewController.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 11/5/18.
//  Copyright © 2018 AdaptConsulting. All rights reserved.
//

import UIKit
import FirebaseAuth


class AddUserInfoViewController: UIViewController {
    
    @IBOutlet weak var nicknameTF: UITextField!
    @IBOutlet weak var nextBtn: RoundedButton!
    
    private var noNickanmeAlert:InfoAlert!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noNickanmeAlert = InfoAlert(viewcontroller: self, title: "Please Add Your Nickname", message: "")
        
        nextBtn.layer.cornerRadius = 5
        nextBtn.layer.masksToBounds = false
        nextBtn.clipsToBounds = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nicknameTF.becomeFirstResponder()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        if(allInfoIsFilled()){
            performSegue(withIdentifier: "AddUserInfoToAndUserImageSegue", sender: self)
        }
        else{
            noNickanmeAlert.show()
        }
    }
    
    func allInfoIsFilled()->Bool{
        if(!(nicknameTF.text?.isEmpty)!){
            return true
        }
        return false
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddUserImageViewController{
            destination.inject(nickname: nicknameTF.text ?? "?")
        }
    }
    

}
