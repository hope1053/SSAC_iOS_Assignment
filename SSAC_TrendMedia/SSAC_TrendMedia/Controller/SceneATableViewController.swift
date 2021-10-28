//
//  SceneATableViewController.swift
//  SSAC_Day13_TrendMedia
//
//  Created by 최혜린 on 2021/10/17.
//

import UIKit
import SwiftyJSON
import Alamofire
import JGProgressHUD

class SceneATableViewController: UITableViewController {
    
    var startPage = 1
    
    var trendingData: [Media] = []
    var TVGenreList: [String: String] = [:]
    var MovieGenreList: [String: String] = [:]
    
    let progress = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.prefetchDataSource = self
        tableHeaderView.updateUI()
        fetchTrendingData()
        fetchGenreData()
    }
    
    @IBOutlet weak var tableHeaderView: UIView!
    
    func fetchGenreData() {
        TheMovieAPIManager.shared.fetchTVGenreData { json in
            for item in json["genres"].arrayValue {
                self.TVGenreList[item["id"].stringValue] = item["name"].stringValue
            }
        }
        TheMovieAPIManager.shared.fetchMovieGenreData { json in
            for item in json["genres"].arrayValue {
                self.MovieGenreList[item["id"].stringValue] = item["name"].stringValue
            }
        }
    }
    
    func fetchTrendingData() {
        progress.textLabel.text = "불러오는 중..."
        progress.show(in: view, animated: true)
        let url = "https://api.themoviedb.org/3/trending/all/week?page=\(startPage)&api_key=\(Constants.API_KEY_TMDB)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let statusCode = response.response?.statusCode ?? 500
                switch statusCode {
                case 200:
//                    print(json)
                    for item in json["results"].arrayValue {
                        if item["media_type"].stringValue == "tv" {
                            let genreID = item["genre_ids"][0].stringValue
                            let releasedDate = item["first_air_date"].stringValue
                            let posterImage = item["poster_path"].stringValue
                            let rate = item["vote_average"].stringValue
                            let title = item["name"].stringValue
                            let overview = item["overview"].stringValue
                            let mediaID = item["id"].intValue
                            let backdrop = item["backdrop_path"].stringValue
                            
                            self.trendingData.append(Media(releasedDate: releasedDate, genre: genreID, backdrop: backdrop, posterImage: posterImage, rate: rate, title: title, mediaType: "tv", overview: overview, mediaID: mediaID))
                        } else if item["media_type"].stringValue == "movie" {
                            let genreID = item["genre_ids"][0].stringValue
                            let releasedDate = item["release_date"].stringValue
                            let posterImage = item["poster_path"].stringValue
                            let rate = item["vote_average"].stringValue
                            let title = item["title"].stringValue
                            let overview = item["overview"].stringValue
                            let mediaID = item["id"].intValue
                            let backdrop = item["backdrop_path"].stringValue
                            
                            self.trendingData.append(Media(releasedDate: releasedDate, genre: genreID, backdrop: backdrop, posterImage: posterImage, rate: rate, title: title, mediaType: "movie", overview: overview, mediaID: mediaID))
                        } else {
                            print("")
                        }
                    }
                    
                    self.tableView.reloadData()
                    self.progress.dismiss(animated: true)
                case 400:
                    print("error")
                default:
                    print("error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendingData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tvShowCell", for: indexPath) as? SceneATableViewCell else {
            return UITableViewCell()
        }
        let MediaInfo = trendingData[indexPath.row]
        
        cell.releaseDate.text = MediaInfo.releasedDate
        let url = URL(string: EndPoint.TMDB_IMAGE_URL + MediaInfo.posterImage)
        cell.posterImageView.kf.setImage(with: url)
        cell.rateLabel.text = "\(MediaInfo.rate)"
        cell.titleLabel.text = MediaInfo.title
        cell.overview.text = MediaInfo.overview
        
        if MediaInfo.mediaType == "tv" {
            let genre = TVGenreList[MediaInfo.genre] ?? ""
            cell.genreLabel.text = "#" + genre
        } else {
            let genre = MovieGenreList[MediaInfo.genre] ?? ""
            cell.genreLabel.text = "#" + genre
        }

        cell.linkButtonTapHandler = {
            let storyboard = UIStoryboard(name: "Web", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            vc.currentTitle = MediaInfo.title
            let nav = UINavigationController(rootViewController: vc)
            self.present(nav, animated: true, completion: nil)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 5 * 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "SceneC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SceneCTableViewController") as! SceneCTableViewController
//        vc.mediaID = trendingData[indexPath.row].mediaID
//        vc.mediaType = trendingData[indexPath.row].mediaType
        vc.currentMedia = trendingData[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "SceneB", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SceneBTableViewController") as! SceneBTableViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func bookButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "BookCollectionView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BookCollectionViewController") as! BookCollectionViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func mapButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "mapView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "mapViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func boxOffcieButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "dayBeforeBoxOffice", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "dayBeforeBoxOfficeTableViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SceneATableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if trendingData.count - 1 == indexPath.row && startPage <= 10 {
                startPage += 1
                fetchTrendingData()
                print("prefetch: \(indexPath)")
            }
        }
    }
}

