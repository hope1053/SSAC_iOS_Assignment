//
//  PostViewController.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/02.
//

import Foundation
import UIKit

import SnapKit

class PostListViewController: UIViewController {
    
    let postTableView = UITableView()
    let viewModel = PostViewModel()
    
    var list: Post = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "새싹농장"
        
        connectView()
        configureView()
        configureTableView()
    }
    
    func configureTableView() {
        postTableView.delegate = self
        postTableView.dataSource = self
        
        postTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        
        postTableView.rowHeight = UITableView.automaticDimension
    }
    
    func connectView() {
        viewModel.postList.bind { post in
            self.list = post
        }
        
        self.viewModel.getPostList { status in
            switch status {
            case .invalidToken:
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            case .reloadTableView:
                self.postTableView.reloadData()
            }
        }
    }
    
    func configureView() {
        view.addSubview(postTableView)
        
        postTableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension PostListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.cellForRowAt(tableView, indexPath: indexPath)
    }
}
