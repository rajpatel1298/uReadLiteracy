//
//  Observer.swift
//  TimBanCu
//
//  Created by Duy Le 2 on 2/3/19.
//  Copyright © 2019 Duy Le 2. All rights reserved.
//

import Foundation
import UIKit

protocol ScrollObserver{
    func onScrolled(view:UIView ,yPosition: CGFloat)
}
