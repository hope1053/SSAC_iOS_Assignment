//
//  PostListViewModel.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/02.
//

import Foundation

enum currentStatus: String {
    case invalidToken
    case reloadTableView
}

class PostListViewModel {
    var postList: Observable<Post> = Observable([])
    
    func getPostList(completion: @escaping (currentStatus) -> Void) {
        APIService.viewPosts { post, error in
            if error == .invalidToken {
                // token이 끝나서 view를 로그인 뷰로 바꿔줘야함
                completion(.invalidToken)
                return
            }
            
            guard let post = post else {
                return
            }
            self.postList.value = post
            completion(.reloadTableView)
        }
    }
}
