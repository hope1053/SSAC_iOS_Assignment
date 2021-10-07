//
//  setupUI.swift
//  SSAC_Day8_anniversaryCalculator
//
//  Created by 최혜린 on 2021/10/07.
//

import Foundation
import UIKit

class roundCornerView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.width/8
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 3.0
    }
}
