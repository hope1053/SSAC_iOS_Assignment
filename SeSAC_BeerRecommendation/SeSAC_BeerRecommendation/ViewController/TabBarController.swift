//
//  TabBarController.swift
//  SeSAC_BeerRecommendation
//
//  Created by 최혜린 on 2021/12/20.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        setTabBarAppearance()
    }
    
    func configureTabBar() {
        let firstViewController = DetailBeerViewController()
        let firstNav = UINavigationController(rootViewController: firstViewController)
        firstViewController.viewType = "Recommend"
        
        let secondViewController = TotalBeerViewController()
        let secondNav = UINavigationController(rootViewController: secondViewController)
        
        firstViewController.tabBarItem = UITabBarItem(title: "오늘의 맥주", image: UIImage(systemName: "hand.thumbsup.circle"), selectedImage: UIImage(systemName: "hand.thumbsup.circle.fill"))
        secondViewController.tabBarItem = UITabBarItem(title: "전체 리스트", image: UIImage(systemName: "list.bullet.circle"), selectedImage: UIImage(systemName: "list.bullet.circle.fill"))
        
        setViewControllers([firstNav, secondNav], animated: true)
    }
    
    func setTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .black
    }
}
