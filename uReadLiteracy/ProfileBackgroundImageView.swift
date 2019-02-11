//
//  ProfileImageView.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/11/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class ProfileBackgroundImageView:RoundedImageView{
    func animate(){
        DispatchQueue.main.async {
            self.alpha = 0.3
            
            UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse,.repeat], animations: {
                self.alpha = 0.1
            }, completion: nil)
        }
    }
}
