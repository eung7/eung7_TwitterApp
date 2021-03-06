//
//  TabBarController.swift
//  eung7 Twitter App
//
//  Created by 김응철 on 2022/03/21.
//

import UIKit

class TabBarController : UITabBarController {
    
    let feedTabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))
    let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
    
    let feedViewController = FeedViewController()
    let profileViewContller = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        tabBar.tintColor = .systemMint
        
        self.viewControllers = [
            UINavigationController(rootViewController: feedViewController),
            UINavigationController(rootViewController: profileViewContller)
        ]
        
        tabBar.backgroundColor = .systemBackground

        feedViewController.tabBarItem = feedTabBarItem
        profileViewContller.tabBarItem = profileTabBarItem
    }
}
