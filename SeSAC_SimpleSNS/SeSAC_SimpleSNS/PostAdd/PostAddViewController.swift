//
//  PostAddViewController.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/03.
//

import Foundation
import UIKit

class PostAddViewController: UIViewController {
    
    let textView = PostEditorView()
    let viewModel = PostAddViewModel()
    
    override func loadView() {
        self.view = textView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "새싹농장 글쓰기"
        textView.detailTextView.delegate = self
        
        configureView()
        connectView()
    }
    
    func configureView() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completedButtonTapped))
    }
    
    func connectView() {
        viewModel.bodyText.bind { detailText in
            self.textView.detailTextView.text = detailText
        }
    }
    
    @objc func completedButtonTapped() {
        viewModel.postDetail {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension PostAddViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.bodyText.value = textView.text ?? ""
    }
}
