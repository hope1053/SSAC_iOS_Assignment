//
//  UIView+Extension.swift
//  SSAC_Day13_TrendMedia
//
//  Created by 최혜린 on 2021/10/17.
//

import Foundation
import UIKit

extension UIView {
    func updateUI() {
        self.layer.cornerRadius = 10
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.masksToBounds = false
    }
}

extension UIImageView {
    func updateImageUI() {
        self.layer.masksToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.cornerRadius = 10
    }
}
