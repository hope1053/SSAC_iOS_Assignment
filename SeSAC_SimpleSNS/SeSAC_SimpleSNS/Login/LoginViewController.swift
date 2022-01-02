//
//  LoginViewController.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/02.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    let startView = StartView(type: "login")
    let viewModel = LoginViewModel()
    
    override func loadView() {
        self.view = startView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "새싹농장 로그인하기"
        
        connectView()
    }
    
    func connectView() {
        viewModel.email.bind { email in
            self.startView.emailTextField.text = email
        }
        
        viewModel.password.bind { password in
            self.startView.passwordTextField.text = password
        }
        
        startView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        startView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        startView.startButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        viewModel.email.value = textField.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField) {
        viewModel.password.value = textField.text ?? ""
    }
    
    @objc func loginButtonTapped() {
        view.endEditing(true)
        viewModel.postLogin {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: PostListViewController())
            windowScene.windows.first?.makeKeyAndVisible()
        }
    }
}
