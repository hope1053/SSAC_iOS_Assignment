//
//  ProductTableViewCell.swift
//  SeSAC_UIPractice
//
//  Created by 최혜린 on 2021/12/17.
//

import UIKit
import SnapKit

class ProductTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let productImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    let productName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let productPrice: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    func configureCell() {
        self.addSubview(productImage)
        self.addSubview(productName)
        self.addSubview(productPrice)
        
        productImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.8)
            $0.width.equalTo(self.productImage.snp.height)
            $0.leadingMargin.equalToSuperview().inset(10)
        }
        
        productName.snp.makeConstraints {
            $0.top.equalTo(self.productImage.snp.top).inset(10)
            $0.leadingMargin.equalTo(self.productImage.snp.trailing).offset(20)
            $0.trailingMargin.equalToSuperview().inset(10)
        }
        
        productPrice.snp.makeConstraints {
            $0.top.equalTo(self.productName.snp.bottom).offset(5)
            $0.leading.equalTo(self.productName.snp.leading)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}
