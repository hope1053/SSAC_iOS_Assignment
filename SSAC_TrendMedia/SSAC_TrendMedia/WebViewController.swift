//
//  WebViewController.swift
//  SSAC_Day14_TrendMedia
//
//  Created by 최혜린 on 2021/10/18.
//

import UIKit

class WebViewController: UIViewController {

    var currentTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = currentTitle ?? "제목이 없음"
    }

}
