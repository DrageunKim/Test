//
//  CustomTabBarController.swift
//  GoodRestaurantNote
//
//  Created by yonggeun Kim on 2023/02/17.
//

import UIKit

class CustomTabBarController: UITabBarController {

    private let firstViewController: UIViewController = {
        let firstVC = UINavigationController(rootViewController: ListViewController())
        firstVC.tabBarItem.selectedImage = .checkmark
        firstVC.tabBarItem.title = "동네대전"
        firstVC.tabBarItem.image = .remove
        return firstVC
    }()
    private let testViewController: UIViewController = {
        let dummyView = UIViewController()
        dummyView.view.backgroundColor = .yellow
        dummyView.tabBarItem.title = "Yellow Dummy"
        dummyView.tabBarItem.image = UIImage(systemName: "trash.fill")
        return dummyView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
    }
    
    private func configureTabBar() {
        tabBar.tintColor = .red
        tabBar.unselectedItemTintColor = .blue
        
        viewControllers = [firstViewController, testViewController]
    }
}
