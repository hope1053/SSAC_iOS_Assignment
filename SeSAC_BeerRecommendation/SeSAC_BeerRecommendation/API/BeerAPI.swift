//
//  BeerAPI.swift
//  SeSAC_BeerRecommendation
//
//  Created by 최혜린 on 2021/12/21.
//

import Foundation

class BeerAPI {
    let randomURL = URL(string: "https://api.punkapi.com/v2/beers/random")!
    
    func requestBeer(completion: @escaping ([Beer]?) -> Void) {
        URLSession.shared.dataTask(with: randomURL) { data, response, error in
            if let error = error {
                print("error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...399).contains(response.statusCode) else {
                print("error")
                return
            }
            
            if let data = data, let beerData = try? JSONDecoder().decode([Beer].self, from: data) {
                completion(beerData)
                return
            }
            
            completion(nil)
        }.resume()
    }
}

