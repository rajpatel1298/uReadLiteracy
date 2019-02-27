//
//  OptionView.swift
//  uReadLiteracy
//
//  Created by Duy Le 2 on 2/27/19.
//  Copyright © 2019 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

class OptionView:UIStackView{
    override func layoutSubviews() {
        alignment = .center
        distribution = .fillEqually
        axis = .horizontal
        spacing = 10
    }
}
