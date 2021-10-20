//
//  theaterLocation.swift
//  SSAC_TrendMedia
//
//  Created by 최혜린 on 2021/10/20.
//

import Foundation

enum TheaterType: Int, CaseIterable {
    case lotte, mega, cgv

    var description: String {
        switch self {
        case .lotte:
            return "롯데시네마"
        case .mega:
            return "메가박스"
        case .cgv:
            return "CGV"
        }
    }
}

struct TheaterLocation {
    let type: String
    let location: String
    let latitude: Double
    let longitude: Double
}
