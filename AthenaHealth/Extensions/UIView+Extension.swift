//
//  UIView+Extension.swift
//  AthenaHealth
//
//  Created by Saurabh Gupta on 19/07/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

extension UIView {
    class func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

