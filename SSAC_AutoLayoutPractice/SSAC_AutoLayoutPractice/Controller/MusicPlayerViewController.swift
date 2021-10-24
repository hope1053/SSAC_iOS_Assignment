//
//  MusicPlayerViewController.swift
//  SSAC_AutoLayoutPractice
//
//  Created by 최혜린 on 2021/10/24.
//

import UIKit

class MusicPlayerViewController: UIViewController {

    @IBOutlet var albumCoverImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        albumCoverImageView.layer.cornerRadius = 10
    }
    
    @IBAction func chevronButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
