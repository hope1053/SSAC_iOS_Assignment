//
//  RealmModel.swift
//  SSAC_ShoppingList
//
//  Created by 최혜린 on 2021/11/02.
//

import Foundation
import RealmSwift

class ShoppingList: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var content: String // 내용(필수)
    @Persisted var isDone: Bool // 구매했는지 확인기능(필수)
    @Persisted var favorite: Bool // 즐겨찾기 기능(필수)

    convenience init(content:String) {
        self.init()
        
        self.content = content
        self.isDone = false
        self.favorite = false
    }
}
