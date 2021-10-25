//
//  UIView+Extension.swift
//  SSAC_Lottery
//
//  Created by 최혜린 on 2021/10/25.
//

import Foundation
import UIKit

class extensionView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let BGcolor = [#colorLiteral(red: 1, green: 0.9088488817, blue: 0, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), #colorLiteral(red: 1, green: 0.3991929293, blue: 0.3315500319, alpha: 1), #colorLiteral(red: 0, green: 0.7649724483, blue: 1, alpha: 1)]
        self.backgroundColor = BGcolor.randomElement()
        self.layer.cornerRadius = self.bounds.width / 2
    }
}
