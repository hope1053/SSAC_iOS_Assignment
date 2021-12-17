//
//  ProductViewController.swift
//  SeSAC_UIPractice
//
//  Created by 최혜린 on 2021/12/17.
//

import UIKit
import SnapKit

class ProductViewController: UIViewController {
    
    private let productList = ProductAPI.getProducts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setTableView()
    }
        
    func setTableView() {
        let productTableView = UITableView()
        view.addSubview(productTableView)
        
        productTableView.snp.makeConstraints {
            $0.leadingMargin.equalToSuperview()
            $0.trailingMargin.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        productTableView.delegate = self
        productTableView.dataSource = self
        
        productTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
    }
}

extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        let row = productList[indexPath.row]
        
        cell.productImage.image = row.image
        cell.productName.text = row.name
        cell.productPrice.text = "\(row.price)원"
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 6
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextController = ProductDetailViewController()
        nextController.currentProduct = productList[indexPath.row]
        self.navigationController?.pushViewController(nextController, animated: true)
    }
}
