//
//  CustomTabBarController.swift
//  GoodRestaurantNote
//
//  Created by yonggeun Kim on 2023/02/17.
//

import UIKit

class CustomTabBarController: UITabBarController {

    private let homeViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: ListViewController())
        viewController.view.backgroundColor = .systemBackground
        viewController.tabBarItem.title = "동네대전"
        viewController.tabBarItem.image = UIImage(systemName: "flag.filled.and.flag.crossed")
        return viewController
    }()
    private let chatViewController: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        viewController.tabBarItem.title = "채팅"
        viewController.tabBarItem.image = UIImage(systemName: "message")
        return viewController
    }()
    private let communityViewController: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        viewController.tabBarItem.title = "커뮤니티"
        viewController.tabBarItem.image = UIImage(systemName: "tray")
        return viewController
    }()
    private let recordViewController: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        viewController.tabBarItem.title = "대전기록"
        viewController.tabBarItem.image = UIImage(systemName: "highlighter")
        return viewController
    }()
    private let etcViewController: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        viewController.tabBarItem.title = "설정"
        viewController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
    }
    
    private func configureTabBar() {
        tabBar.tintColor = .systemMint
        tabBar.unselectedItemTintColor = .label
        tabBar.layer.borderWidth = 0.1
        tabBar.layer.borderColor = UIColor.label.cgColor
        tabBar.layer.cornerRadius = 10
        
        viewControllers = [
            homeViewController,
            chatViewController,
            communityViewController,
            recordViewController,
            etcViewController
        ]
    }
}
