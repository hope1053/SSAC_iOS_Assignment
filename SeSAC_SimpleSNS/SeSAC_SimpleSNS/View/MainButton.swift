//
//  MainButton.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/02.
//

import Foundation
import UIKit

class MainButton: UIButton {
    
    var cornerRadius: CGFloat {
        get {
            self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    var bgColor: UIColor {
        get {
            self.backgroundColor!
        }
        set {
            self.backgroundColor = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.cornerRadius = 10
        self.bgColor = UIColor().mainColor
        self.setTitleColor(.white, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
