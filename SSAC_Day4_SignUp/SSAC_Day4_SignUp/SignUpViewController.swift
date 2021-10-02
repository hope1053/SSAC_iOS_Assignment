//
//  SignUpViewController.swift
//  SSAC_Day4_SignUp
//
//  Created by 최혜린 on 2021/09/30.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var stackViewHeight: NSLayoutConstraint!
    @IBOutlet var recommendCode: UITextField!
    @IBOutlet var place: UITextField!
    @IBOutlet var nickName: UITextField!
    @IBOutlet var ID: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var additionalSwitch: UISwitch!
    @IBOutlet var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
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
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        if ID.text == "" {
            ID.attributedPlaceholder = NSAttributedString(string: "ID를 입력해주세요", attributes: [.foregroundColor: UIColor.red])
        }
        
        if password.text == "" {
            password.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력해주세요", attributes: [.foregroundColor: UIColor.red])
        } else if password.text!.count < 6 {
            password.text = ""
            password.attributedPlaceholder = NSAttributedString(string: "최소 6자리 이상으로 입력해주세요", attributes: [.foregroundColor: UIColor.red])
        }
        
        if Int(recommendCode.text!) == nil {
            recommendCode.text = ""
            recommendCode.attributedPlaceholder = NSAttributedString(string: "숫자만 입력해주세요", attributes: [.foregroundColor: UIColor.red])
        }
        
        let resultText = """
        회원가입 정보 확인
        ID: \(ID.text ?? "hope1053")
        PW: \(password.text!)
        NICK: \(nickName.text!)
        LOCATION: \(place.text!)
        CODE: \(recommendCode.text!)
        """
        print(resultText)
    }
}
