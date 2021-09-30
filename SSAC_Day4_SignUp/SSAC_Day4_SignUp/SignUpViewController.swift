//
//  SignUpViewController.swift
//  SSAC_Day4_SignUp
//
//  Created by 최혜린 on 2021/09/30.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var stackViewHeight: NSLayoutConstraint!
    @IBOutlet var signUpStack: UIStackView!
    @IBOutlet var recommendCode: UITextField!
    @IBOutlet var place: UITextField!
    @IBOutlet var nickName: UITextField!
    @IBOutlet var additionalSwitch: UISwitch!
    @IBOutlet var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        // Do any additional setup after loading the view.
    }
    
    func setUp() {
        registerButton.clipsToBounds = true
        registerButton.layer.cornerRadius = 6
    }
    
    @IBAction func BGTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func switchTapped(_ sender: UISwitch) {
        if additionalSwitch.isOn {
            recommendCode.isHidden = false
            place.isHidden = false
            nickName.isHidden = false
            stackViewHeight.constant *= 7/4
        } else {
            recommendCode.isHidden = true
            place.isHidden = true
            nickName.isHidden = true
            stackViewHeight.constant *= 4/7
        }
    }
}
