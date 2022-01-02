//
//  StartView.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/02.
//

import Foundation
import UIKit

import SnapKit

class StartView: UIView {
    
    var type: String = ""
    
    let emailTextField: MainTextField = {
        let textField = MainTextField()
        textField.placeholder = "이메일 주소"
        return textField
    }()
    
    let nickNameTextField: MainTextField = {
        let textField = MainTextField()
        textField.placeholder = "닉네임"
        return textField
    }()
    
    let passwordTextField: MainTextField = {
        let textField = MainTextField()
        textField.placeholder = "비밀번호"
        return textField
    }()
    
    let passwordCheckTextField: MainTextField = {
        let textField = MainTextField()
        textField.placeholder = "비밀번호 확인"
        return textField
    }()
    
    let startButton: MainButton = {
        let button = MainButton()
        button.setTitle("시작하기", for: .normal)
        return button
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .fill
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .fillEqually
        return view
    }()
    
    required init(type: String) {
        super.init(frame: .zero)
        self.type = type
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        
        self.addSubview(stackView)
        
        [emailTextField, nickNameTextField, passwordTextField, passwordCheckTextField, startButton].forEach { subView in
            self.stackView.addArrangedSubview(subView)
        }
        
        stackView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.95)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
        }
        
        if type == "register" {
            stackView.snp.makeConstraints { make in
                make.height.equalToSuperview().multipliedBy(0.3)
            }
        } else {
            nickNameTextField.isHidden = true
            passwordCheckTextField.isHidden = true
            stackView.snp.makeConstraints { make in
                make.height.equalToSuperview().multipliedBy(0.18)
            }
        }
    }
}
