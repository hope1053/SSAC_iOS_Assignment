//
//  ViewController.swift
//  SSAC_AutoLayoutPractice
//
//  Created by 최혜린 on 2021/10/24.
//

import UIKit

class KakaoTalkViewController: UIViewController {

    @IBOutlet var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 3
    }

    @IBAction func XmarkButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

