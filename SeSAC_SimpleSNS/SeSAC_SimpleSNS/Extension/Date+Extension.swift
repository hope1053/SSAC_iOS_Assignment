//
//  DateFormatter+Extension.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/02.
//

import Foundation

extension Date {
    func dateStringToDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: dateString)!
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: date)
    }
}
