//
//  UIAlertController+Extension.swift
//  SSAC_ShoppingList
//
//  Created by 최혜린 on 2021/11/05.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(_ title: String, _ message: String? = nil, _ handler: ((UIAlertAction) -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: handler)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
