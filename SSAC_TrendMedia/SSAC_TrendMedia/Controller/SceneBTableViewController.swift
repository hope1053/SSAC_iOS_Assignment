//
//  SceneTableViewController.swift
//  SSAC_Day13_TrendMedia
//
//  Created by 최혜린 on 2021/10/17.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class SceneBTableViewController: UITableViewController, UITableViewDataSourcePrefetching {
    //&& movieData.count < totalCount
    // 셀이 화면에 보이기 전에 필요한 리소스를 미리 다운 받는 기능(덩어리 형태로 다운)
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if movieData.count == indexPath.row + 1 && movieData.count < totalCount {
                startPage += 10
                fetchMovieData()
                print("prefetch: \(indexPath)")
            }
        }
    }
    
    // 다운 받는거 취소하는 기능
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소:\(indexPaths)")
    }
    
    @IBOutlet var movieTableView: UITableView!
    @IBOutlet var movieSeachBar: UISearchBar!
    
//    let tvShowInformation = TvShowInformation()
    var startPage = 1
    var totalCount = 0
    var movieData: [TvShow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieSeachBar.delegate = self
//        movieSeachBar.showsCancelButton = true
        movieTableView.prefetchDataSource = self
        
        navigationItem.title = "영화 검색"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
    }
    
    // 네이버 영화 네트워크 통신
    func fetchMovieData() {
        // 옵셔널 스트링 타입 -> 옵셔널 풀어줘야함~ -> 쿼리에 문제가 없을 때 네트워킹을 진행해라~
        let searchKeyword = movieSeachBar.text ?? ""
        if let query = searchKeyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=10&start=\(startPage)"
            let header: HTTPHeaders = [
                "X-Naver-Client-Id":"J6_SoHpZG0H5O1jtkL6Z",
                "X-Naver-Client-Secret":"bEl_k79lLz"
            ]
            AF.request(url, method: .get, headers: header).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
//                    self.movieData = []
                    self.totalCount = json["total"].intValue
                    for item in json["items"].arrayValue {
                        let titleValue = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                        let imageData = item["image"].stringValue
                        let linkData = item["link"].stringValue
                        let userRatingData = item["userRating"].stringValue
                        let subtitle = item["subtitle"].stringValue
                        
                        let data = TvShow(titlData: titleValue, imageData: imageData, linkData: linkData, userRatingData: userRatingData, subtitle: subtitle)
                        
                        self.movieData.append(data)
                    }
                    
                    self.movieTableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SceneBCell", for: indexPath) as? SceneBTableViewCell else {
            return UITableViewCell()
        }
        
        let data = movieData[indexPath.row]
        
        if let url = URL(string: data.imageData) {
            cell.posterImageView.kf.setImage(with: url)
        } else {
            cell.posterImageView.image = UIImage(systemName: "star")
        }
        
        cell.titleLabel.text = data.titlData
        cell.releaseDate.text = data.subtitle
        cell.overview.text = data.linkData
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 6
    }
}

extension SceneBTableViewController: UISearchBarDelegate {
    // 취소버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        movieData.removeAll()
        startPage = 1
        tableView.reloadData()
        movieSeachBar.setShowsCancelButton(false, animated: true)
    }
    
    // 서치바에서 커서가 깜빡이기 시작할때를 인식함
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        movieSeachBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        movieData.removeAll()
        startPage = 1
        fetchMovieData()
    }
    
    // 실시간으로 검색할 수 있는 기능~
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        <#code#>
//    }
}
