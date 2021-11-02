//
//  WebViewController.swift
//  SSAC_Day14_TrendMedia
//
//  Created by 최혜린 on 2021/10/18.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON

class WebViewController: UIViewController {

    @IBOutlet var webView: WKWebView!

    var currentMedia: Media?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = currentMedia?.title
        fetchVideoData()
    }
    
    func fetchVideoData() {
        guard let mediaType = currentMedia?.mediaType else {return}
        let url = "https://api.themoviedb.org/3/\(mediaType)/\(currentMedia!.mediaID)/videos?api_key=\(Constants.API_KEY_TMDB)&language=en-US"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let videoResult = json["results"].arrayValue[0]
                if videoResult["site"].stringValue == "YouTube" {
                    if let url = URL(string: "https://www.youtube.com/watch?v=\(videoResult["key"])") {
                        let request = URLRequest(url: url)
                        self.webView.load(request)
                    }
                } else {
                    if let url = URL(string: "https://vimeo.com/\(videoResult["key"])") {
                        let request = URLRequest(url: url)
                        self.webView.load(request)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
