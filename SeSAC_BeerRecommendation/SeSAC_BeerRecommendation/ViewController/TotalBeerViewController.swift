//
//  TotalBeerViewController.swift
//  SeSAC_BeerRecommendation
//
//  Created by 최혜린 on 2021/12/20.
//

import Foundation
import UIKit

class TotalBeerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }
    
    func setViewController() {
        view.backgroundColor = .white
        self.navigationItem.title = "전체 리스트"
    }
    
}
