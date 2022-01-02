//
//  PostAddViewModel.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/03.
//

import Foundation

class PostAddViewModel {
    var bodyText: Observable<String> = Observable("")
    
    func postDetail(completion: @escaping () -> Void) {
        APIService.addPost(text: bodyText.value) { post, error in
            guard let post = post else {
                return
            }
            print(post)
            completion()
        }
    }
    
}
