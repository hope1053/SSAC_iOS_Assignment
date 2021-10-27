//
//  WeatherAPIManager.swift
//  SSAC_WeatherAPI
//
//  Created by 최혜린 on 2021/10/27.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherAPIManager {
    static let shared = WeatherAPIManager()
    
    typealias CompletionHandler = (Int, JSON) -> ()
    
    func getCurrentWeather(_ latitude: Double, _ longitude: Double, result: @escaping CompletionHandler) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.API_KEY_WEATHER)"
        AF.request(url, method: .get).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let statusCode = response.response?.statusCode ?? 500
                result(statusCode, json)
            case .failure(let error):
                print(error)
            }
        }
    }
}
