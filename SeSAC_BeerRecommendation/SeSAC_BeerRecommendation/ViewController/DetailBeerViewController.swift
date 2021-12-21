//
//  DetailBeerViewController.swift
//  SeSAC_BeerRecommendation
//
//  Created by 최혜린 on 2021/12/20.
//

import UIKit
import SnapKit
import Kingfisher

class DetailBeerViewController: UIViewController {
    
    let detailView = BeerDetailView()
    
    let beerAPI = BeerAPI()
    
    var currentBeer: Beer?
    
    var viewType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTypeOfView()
        view.addSubview(detailView)
        detailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        beerAPI.requestBeer { data in
            self.currentBeer = data?.first
            print(self.currentBeer)
            DispatchQueue.main.async {
//                let url = URL(string: self.currentBeer?.imageURL ?? "")
//                self.detailView.imageView.kf.setImage(with: url)
            }
        }
    }
    
    func setTypeOfView() {
        self.navigationItem.title = viewType == "Recommend" ? "오늘의 추천 맥주" : "상세 정보"
    }
}
