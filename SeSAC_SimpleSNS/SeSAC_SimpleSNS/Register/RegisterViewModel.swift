//
//  RegisterViewModel.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/02.
//

import Foundation

class RegisterViewModel {
    var username: Observable<String> = Observable("")
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    
    func postRegister(completion: @escaping () -> Void) {
        APIService.register(username: username.value, email: email.value, password: password.value) { user, error in
            guard let user = user else { return }
            
            UserDefaults.standard.set(user.user.username, forKey: "username")
            UserDefaults.standard.set(user.user.id, forKey: "id")
            UserDefaults.standard.set(user.user.email, forKey: "email")
            
            completion()
        }
    }
}
