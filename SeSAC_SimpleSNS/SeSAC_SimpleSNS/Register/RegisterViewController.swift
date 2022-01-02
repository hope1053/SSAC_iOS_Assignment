//
//  RegisterViewController.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/02.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    
    let startView = StartView(type: "register")
    
    override func loadView() {
        self.view = startView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "새싹농장 가입하기"
    }
}
