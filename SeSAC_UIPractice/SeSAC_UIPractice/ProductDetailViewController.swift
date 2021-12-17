//
//  ProductDetailViewController.swift
//  SeSAC_UIPractice
//
//  Created by 최혜린 on 2021/12/17.
//

import UIKit
import SnapKit

class ProductDetailViewController: UIViewController {
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 23)
        label.numberOfLines = 0
        return label
    }()
    
    var currentProduct: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
        [productImageView, productNameLabel].forEach { subView in
            view.addSubview(subView)
        }
        
        configureView()
    }
    
    func setView() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func configureView() {
        productImageView.image = currentProduct?.image
        productNameLabel.text = currentProduct!.name
        
        productImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(self.productImageView.snp.width)
        }
        
        productNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.productImageView.snp.bottom).offset(80)
            $0.leadingMargin.equalToSuperview().inset(15)
            $0.trailingMargin.equalToSuperview().inset(15)
        }
    }
}
