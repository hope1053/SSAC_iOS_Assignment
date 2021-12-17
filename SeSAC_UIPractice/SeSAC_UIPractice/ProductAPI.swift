//
//  ProductAPI.swift
//  SeSAC_UIPractice
//
//  Created by 최혜린 on 2021/12/17.
//

import UIKit

class ProductAPI {
    static func getProducts() -> [Product] {
        let products = [
            Product(image: UIImage(named: "음식1"), name: "마라탕", price: 500000),
            Product(image: UIImage(named: "음식2"), name: "족발", price: 500000),
            Product(image: UIImage(named: "음식3"), name: "닭꼬치", price: 500000),
            Product(image: UIImage(named: "음식4"), name: "떡볶이", price: 500000),
            Product(image: UIImage(named: "음식5"), name: "덮밥", price: 500000),
            Product(image: UIImage(named: "음식6"), name: "케이크", price: 500000),
            Product(image: UIImage(named: "음식7"), name: "오므라이스", price: 500000),
            Product(image: UIImage(named: "음식8"), name: "부리또볼", price: 500000),
            Product(image: UIImage(named: "음식9"), name: "장어", price: 500000),
            Product(image: UIImage(named: "음식10"), name: "딸기라떼", price: 500000)
        ]
        
        return products
    }
}
