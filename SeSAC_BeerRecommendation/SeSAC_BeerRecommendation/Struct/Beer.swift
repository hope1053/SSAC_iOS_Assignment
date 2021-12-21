//
//  Beer.swift
//  SeSAC_BeerRecommendation
//
//  Created by 최혜린 on 2021/12/21.
//

import Foundation

struct Beer: Codable {
    let name, tagline, beerDescription, imageURL, brewersTips: String
    let foodPairing: [String]
    
    enum CodingKeys: String, CodingKey {
        case name, tagline
        case beerDescription = "description"
        case imageURL = "image_url"
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
    }
}
