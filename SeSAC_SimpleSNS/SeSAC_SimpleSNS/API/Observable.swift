//
//  Observable.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/02.
//

import Foundation
import UIKit

class Observable<T> {
    var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(completion: @escaping (T) -> Void) {
        completion(value)
        listener = completion
    }
}
