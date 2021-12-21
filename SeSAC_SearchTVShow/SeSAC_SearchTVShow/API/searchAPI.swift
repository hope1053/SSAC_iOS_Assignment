//
//  searchAPI.swift
//  SeSAC_SearchTVShow
//
//  Created by 최혜린 on 2021/12/22.
//

import Foundation

class searchAPI {
    func requestTVShow(keyword: String, page: Int, completion: @escaping (TVShow?) -> Void) {
        if let query = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let stringURL = "https://api.themoviedb.org/3/search/tv?api_key=\(Constants.API_KEY_TMDB)&language=ko-KR&page=\(page)&query=\(query)&include_adult=false"
            let sourceURL = URL(string: stringURL)!
            
            URLSession.shared.dataTask(with: sourceURL) { data, response, error in
                if let error = error {
                    print("error", error)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...399).contains(response.statusCode) else {
                    print("error")
                    return
                }
                
                if let data = data, let searchData = try? JSONDecoder().decode(TVShow.self, from: data) {
                    completion(searchData)
                    return
                }
                
                completion(nil)
            }.resume()
        }
    }
}
