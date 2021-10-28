//
//  MainViewController.swift
//  SSAC_AutoLayoutPractice
//
//  Created by 최혜린 on 2021/10/24.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func kakaoButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "KakaotalkProfile", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "KakaoTalkViewController")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func musicPlayerTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "MusicPlayer", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MusicPlayerViewController")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func BaeminButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Baemin", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BaeminViewController")
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
}
