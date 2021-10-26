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

class SceneBTableViewController: UITableViewController {
    @IBOutlet var movieTableView: UITableView!
    @IBOutlet var movieSeachBar: UISearchBar!
    
//    let tvShowInformation = TvShowInformation()
    
    var movieData: [TvShow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieSeachBar.delegate = self
        
        navigationItem.title = "영화 검색"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
    }
    
    // 네이버 영화 네트워크 통신
    func fetchMovieData() {
        // 옵셔널 스트링 타입 -> 옵셔널 풀어줘야함~ -> 쿼리에 문제가 없을 때 네트워킹을 진행해라~
        let searchKeyword = movieSeachBar.text ?? ""
        if let query = searchKeyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=15&start=1"
            let header: HTTPHeaders = [
                "X-Naver-Client-Id":"J6_SoHpZG0H5O1jtkL6Z",
                "X-Naver-Client-Secret":"bEl_k79lLz"
            ]
            AF.request(url, method: .get, headers: header).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.movieData = []
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
        let url = URL(string: data.imageData)
        cell.posterImageView.kf.setImage(with: url)
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchMovieData()
    }
}
