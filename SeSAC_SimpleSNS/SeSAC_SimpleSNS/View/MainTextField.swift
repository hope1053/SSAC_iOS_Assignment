//
//  MainTextField.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/02.
//

import Foundation
import UIKit

class MainTextField: UITextField {
    
    var cornerRadius: CGFloat {
        get {
            self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    var borderWidth: CGFloat {
        get {
            self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    var borderColor: UIColor {
        get {
            UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.cornerRadius = 10
        self.borderColor = .lightGray
        self.borderWidth = 1
        
        self.addLeftPadding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
