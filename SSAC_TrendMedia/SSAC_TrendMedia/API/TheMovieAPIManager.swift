//
//  TheMovieAPIManager.swift
//  SSAC_TrendMedia
//
//  Created by 최혜린 on 2021/10/27.
//

import Foundation
import SwiftyJSON
import Alamofire

class TheMovieAPIManager {
    static let shared = TheMovieAPIManager()
    
    typealias GenreCompletionHandler = (JSON) -> ()
    
    func fetchMovieGenreData(result: @escaping GenreCompletionHandler) {
        AF.request(EndPoint.TMDB_MOVIE_GENRE_URL + Constants.API_KEY_TMDB, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                result(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchTVGenreData(result: @escaping GenreCompletionHandler) {
        AF.request(EndPoint.TMDB_TV_GENRE_URL + Constants.API_KEY_TMDB, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                result(json)
            case .failure(let error):
                print(error)
            }
        }
    }
}
