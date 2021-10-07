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
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.borderWidth = 4.0
    }
}
