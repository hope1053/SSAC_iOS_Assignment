//
//  APIKey.swift
//  SSAC_TrendMedia
//
//  Created by 최혜린 on 2021/10/26.
//

import Foundation

struct Constants {
    static let API_KEY_MOVIE = "802d2abe6986dc085e82100c183f1a0c"
    static let API_KEY_TMDB = "0c2d8e1e740122548f73e32fff0245c7"
}

struct EndPoint {
    static let TMDB_URL = "https://api.themoviedb.org/3/trending/all/week?api_key="
    static let TMDB_IMAGE_URL = "https://image.tmdb.org/t/p/original"
    static let TMDB_MOVIE_GENRE_URL = "https://api.themoviedb.org/3/genre/movie/list?api_key="
    static let TMDB_TV_GENRE_URL = "https://api.themoviedb.org/3/genre/tv/list?api_key="
    
//    static let TMDB_MOVIE_CREDIT_URL = "https://api.themoviedb.org/3/movie/{movie_id}/credits?api_key=0c2d8e1e740122548f73e32fff0245c7&language=en-US"
}
