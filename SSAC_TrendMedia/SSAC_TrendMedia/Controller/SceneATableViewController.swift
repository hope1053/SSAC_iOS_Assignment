//
//  SceneATableViewController.swift
//  SSAC_Day13_TrendMedia
//
//  Created by 최혜린 on 2021/10/17.
//

import UIKit
import SwiftyJSON

class SceneATableViewController: UITableViewController {

//    let tvShowInformation = TvShowInformation()
    
    var trendingData: [Media] = []
    var TVGenreList: [String:String] = [:]
    var MovieGenreList: [String:String] = [:]
    
    var TmpList : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableHeaderView.updateUI()
        fetchTrendingData()
    }
    @IBOutlet weak var tableHeaderView: UIView!
    
    func fetchGenreData() {
        TheMovieAPIManager.shared.fetchTVGenreData { json in
            for item in json["genres"].arrayValue {
                let value = item["id"].stringValue
                self.TVGenreList[item["id"].stringValue] = item["name"].stringValue
                self.TmpList.append(value)
            }
        }
        TheMovieAPIManager.shared.fetchMovieGenreData { json in
            for item in json["genres"].arrayValue {
                self.MovieGenreList[item["id"].stringValue] = item["name"].stringValue
            }
        }
        print(TmpList)
    }
    
    func fetchTrendingData() {
        TheMovieAPIManager.shared.fetchTrendingData { statusCode, json in
            switch statusCode {
            case 200:
                self.fetchGenreData()
                for item in json["results"].arrayValue {
                    if self.trendingData.count == 20 { break }
                    if item["media_type"].stringValue == "tv" {
                        let genreID = item["genre_ids"][0].stringValue
                        let genre = self.TVGenreList[genreID] ?? "장르가 없습니다."
                        let releasedDate = item["first_air_date"].stringValue
                        let posterImage = item["poster_path"].stringValue
                        let rate = item["vote_average"].stringValue
                        let title = item["name"].stringValue
                        
                        self.trendingData.append(Media(releasedDate: releasedDate, genre: genre, posterImage: posterImage, rate: rate, title: title))
                    } else if item["media_type"].stringValue == "movie" {
                        let genreID = item["genre_ids"][0].stringValue
                        let genre = self.MovieGenreList[genreID] ?? "장르가 없습니다."
                        let releasedDate = item["release_date"].stringValue
                        let posterImage = item["poster_path"].stringValue
                        let rate = item["vote_average"].stringValue
                        let title = item["title"].stringValue
                        
                        self.trendingData.append(Media(releasedDate: releasedDate, genre: genre, posterImage: posterImage, rate: rate, title: title))
                    } else {
                        print("")
                    }
                }
                
                self.tableView.reloadData()
            case 400:
                print("error")
            default:
                print("error")
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
        cell.genreLabel.text = "#\(MediaInfo.genre)"
        let url = URL(string: EndPoint.TMDB_POSTER_URL + MediaInfo.posterImage)
        cell.posterImageView.kf.setImage(with: url)
        cell.rateLabel.text = "\(MediaInfo.rate)"
        cell.titleLabel.text = MediaInfo.title

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
//        vc.currentTvShow = trendingData[indexPath.row]
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

