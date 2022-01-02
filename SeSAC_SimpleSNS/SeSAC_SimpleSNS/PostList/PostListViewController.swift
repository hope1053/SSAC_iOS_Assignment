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
    let addPostButton: MainButton = {
        let button = MainButton()
        button.cornerRadius = UIScreen.main.bounds.width * 0.22 * 0.5
        button.addTarget(self, action: #selector(addPostButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let viewModel = PostViewModel()
    
    var list: Post = []
    
    @objc func addPostButtonTapped() {
        let vc = PostAddViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "새싹농장"
        
        connectView()
        configureView()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadPosts()
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
        
        loadPosts()
    }
    
    func loadPosts() {
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
        [postTableView, addPostButton].forEach { subView in
            self.view.addSubview(subView)
        }
        
        postTableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        addPostButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.22)
            make.height.equalTo(addPostButton.snp.width)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = viewModel.didSelectRowAt(tableView, indexPath: indexPath)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
