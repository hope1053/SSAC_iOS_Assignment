//
//  UICollectionViewCell+Extension.swift
//  SeSAC_SearchTVShow
//
//  Created by 최혜린 on 2021/12/22.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension UICollectionViewCell: ReusableView {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
