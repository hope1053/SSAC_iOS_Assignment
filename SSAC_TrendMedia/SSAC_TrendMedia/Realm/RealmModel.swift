//
//  RealmModel.swift
//  SSAC_TrendMedia
//
//  Created by 최혜린 on 2021/11/02.
//

import Foundation
import RealmSwift

class dayBeforeBoxOffice: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var dateInfo: String
    @Persisted var boxOfficeList: List<String>
    
    convenience init(dateInfo: String, boxOfficeList: List<String>) {
        self.init()
        self.dateInfo = dateInfo
        self.boxOfficeList = boxOfficeList
    }
}
