//
//  MainTabBarController.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    private func configureTabBar() {
        
        UITabBar.appearance().backgroundColor = .clear
        UITabBar.appearance().tintColor = .purple1
        UITabBar.appearance().unselectedItemTintColor = .systemGray
        
        viewControllers = [
            createNavController(for: HomeVC(),
                                title: "Home",
                                imageName: "house",
                                selectedImage: "house.fill"),
            
            createNavController(for: SearchVC(),
                                title: "Search",
                                imageName: "magnifyingglass",
                                selectedImage: "magnifyingglass"),
            
            createNavController(for: FavoritesVC(),
                                title: "Favorites",
                                imageName: "bookmark",
                                selectedImage: "bookmark"),
            
            createNavController(for: ProfileVC(),
                                title: "Profile",
                                imageName: "person.crop.circle",
                                selectedImage: "person.crop.circle")
        ]
    }
    
    fileprivate func createNavController(for viewController: UIViewController, title: String, imageName: String, selectedImage: String? = nil) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .systemBackground
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)
        navController.tabBarItem.selectedImage = UIImage(systemName: selectedImage!)
        return navController
    }
}

