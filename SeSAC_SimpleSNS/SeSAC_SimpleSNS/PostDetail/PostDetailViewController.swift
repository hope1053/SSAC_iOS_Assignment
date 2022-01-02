//
//  PostDetailViewController.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/03.
//

import Foundation
import UIKit

class PostDetailViewController: UIViewController {
    
    let viewModel = PostDetailViewModel()
    var currentPost: PostElement? {
        didSet {
            viewModel.currentPost.value = self.currentPost!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        configureView()
    }
    
    func connectView() {
        viewModel.currentPost.bind { post in
            self.currentPost = post
        }
    }
    
    func configureView() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(menuButtonTapped))
    }
    
    @objc func menuButtonTapped() {
        let writerID = currentPost?.user.id
        // 로그인 다시 한 번 진행 후 확인해야함
        let myID = UserDefaults.standard.value(forKey: "id") as? Int
        
        if writerID == myID {
            showActionSheet()
        } else {
            showAlert()
        }
    }
    
    func showActionSheet() {
        let alert = UIAlertController(title: "메뉴", message: "", preferredStyle: .actionSheet)
        
        let edit = UIAlertAction(title: "수정", style: .default)
        let delete = UIAlertAction(title: "삭제", style: .destructive) { _ in
            self.checkAlert()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(edit)
        alert.addAction(delete)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "알림", message: "본인이 작성한 글만 수정 및 삭제할 수 있습니다!", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
    func checkAlert() {
        let alert = UIAlertController(title: "알림", message: "글을 삭제하시겠습니까?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            self.viewModel.deletePost {
                self.navigationController?.popViewController(animated: true)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}
