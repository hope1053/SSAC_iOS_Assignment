//
//  MainViewController.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/02.
//

import Foundation
import UIKit

import SnapKit

class MainViewController: UIViewController {
    
    let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo_ssac_clear")
        return image
    }()
    
    let registerButton: MainButton = {
        let button = MainButton()
        button.setTitle("시작하기", for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(UIColor().mainColor, for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func registerButtonTapped() {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func loginButtonTapped() {
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(registerEnded), name: NSNotification.Name("registerEnded"), object: nil)
        
        view.backgroundColor = .white
        setUpConstraints()
    }
    
//    @objc func registerEnded() {
//        let vc = LoginViewController()
//        let currentEmail = UserDefaults.standard.value(forKey: "email")
//        vc.startView.emailTextField.text = currentEmail as? String
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    func setUpConstraints() {
        [logoImage, registerButton, loginButton].forEach { subView in
            self.view.addSubview(subView)
        }
        
        logoImage.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(self.logoImage.snp.width)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.7)
        }
        
        loginButton.snp.makeConstraints { make in
            make.width.equalTo(registerButton)
            make.height.equalTo(registerButton)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
        }
        
        registerButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.05)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.loginButton.snp.top).offset(-5)
        }
    }
}
