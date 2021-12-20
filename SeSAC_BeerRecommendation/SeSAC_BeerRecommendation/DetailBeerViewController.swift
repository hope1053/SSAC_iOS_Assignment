//
//  DetailBeerViewController.swift
//  SeSAC_BeerRecommendation
//
//  Created by 최혜린 on 2021/12/20.
//

import UIKit

class DetailBeerViewController: UIViewController {
    
    var viewType: String = ""
    // viewType이 Recommend이면 추천, Detail이면 자세한 내용 보여주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setTypeOfView()
    }
    
    func setTypeOfView() {
        self.navigationItem.title = viewType == "Recommend" ? "오늘의 추천 맥주" : "상세 정보"
    }
    
}
