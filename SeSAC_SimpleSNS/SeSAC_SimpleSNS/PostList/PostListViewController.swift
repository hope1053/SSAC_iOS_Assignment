//
//  PostViewController.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/02.
//

import Foundation
import UIKit

class PostListViewController: UIViewController {
    
//    let tableView = UITableView()
    let viewModel = PostListViewModel()
    
    var list: Post = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        viewModel.postList.bind { post in
            self.list = post
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.getPostList { status in
                switch status {
                case .invalidToken:
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                    windowScene.windows.first?.makeKeyAndVisible()
                case .reloadTableView:
                    print("success")
                }
            }
        }
    }
}
