//
//  DateFormatter+Extension.swift
//  SSAC_TrendMedia
//
//  Created by 최혜린 on 2021/11/19.
//

import Foundation

extension DateFormatter {
    static var ticketOpenDateFormatter: DateFormatter {
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일 a h시"
        return format
    }
}
