//
//  SeasonInfo.swift
//  SeSAC_SearchTVShow
//
//  Created by 최혜린 on 2021/12/21.
//

import Foundation

struct SeasonInfo: Codable {
    let id: Int
    let name: String
    let seasons: [Season]
}

// MARK: - Season
struct Season: Codable {
    let airDate: String?
    let episodeCount, id: Int
    let name, overview, posterPath: String
    let seasonNumber: Int

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}
