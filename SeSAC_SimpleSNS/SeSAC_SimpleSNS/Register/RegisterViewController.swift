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
    let viewModel = RegisterViewModel()
    
    override func loadView() {
        self.view = startView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "새싹농장 가입하기"
        
        connectView()
    }
    
    func connectView() {
        viewModel.email.bind { email in
            self.startView.emailTextField.text = email
        }
        
        viewModel.username.bind { username in
            self.startView.nickNameTextField.text = username
        }
        
        viewModel.password.bind { password in
            self.startView.passwordTextField.text = password
        }
        
        startView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        startView.nickNameTextField.addTarget(self, action: #selector(nickNameTextFieldDidChange), for: .editingChanged)
        startView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        
        startView.startButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        viewModel.email.value = textField.text ?? ""
    }
    
    @objc func nickNameTextFieldDidChange(_ textField: UITextField) {
        viewModel.username.value = textField.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField) {
        viewModel.password.value = textField.text ?? ""
    }
    
    @objc func registerButtonTapped() {
        self.view.endEditing(true)
        viewModel.postRegister {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
