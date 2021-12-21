//
//  SearchTVShow.swift
//  SeSAC_SearchTVShow
//
//  Created by 최혜린 on 2021/12/21.
//

import Foundation

// MARK: - TVShow
struct TVShow: Codable {
    let page: Int
    let results: [SearchTVShow]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SearchTVShow: Codable {
    let id: Int
    let posterPath: String

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
    }
}
