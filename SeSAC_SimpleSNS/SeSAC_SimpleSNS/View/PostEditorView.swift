//
//  PostEditorView.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/03.
//

import UIKit
import SnapKit

class PostEditorView: UIView {
    
    let detailTextView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.addSubview(detailTextView)
        
        detailTextView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
