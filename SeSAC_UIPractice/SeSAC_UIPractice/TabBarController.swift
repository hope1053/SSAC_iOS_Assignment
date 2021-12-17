//
//  TabBarController.swift
//  SeSAC_UIPractice
//
//  Created by 최혜린 on 2021/12/17.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
        setUpTabBarAppearance()
    }
    
    func configureTabBarController() {
        let firstView = ProductViewController()
        let firstNav = UINavigationController(rootViewController: firstView)
        let secondView = SettingViewController()
        let secondNav = UINavigationController(rootViewController: secondView)
        
        firstView.tabBarItem = UITabBarItem(title: "상품", image: UIImage(systemName: "list.bullet.circle"), selectedImage: UIImage(systemName: "list.bullet.circle.fill"))
        secondView.tabBarItem = UITabBarItem(title: "나의 당근", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill"))
        
        firstView.navigationItem.title = "역삼동"
        secondView.title = "나의 당근"
        
        setViewControllers([firstNav, secondNav], animated: true)
    }
    
    func setUpTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .black
    }
}
