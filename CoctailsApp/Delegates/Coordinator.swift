//
//  Coordinator.swift
//  CoctailsApp
//
//  Created by Artur Sokolov on 28.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import UIKit

class Coordinator {
    
    func presentInitialScreen(on window: UIWindow) {
        // Search
        let router = SearchRouter()
        let viewModel = SearchViewModel(router: router)
        let viewController = SearchViewController()
        
        viewController.viewModel = viewModel
        viewController.tabBarItem.title = "Search"
        viewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        router.baseViewController = viewController
        
        let navigationController = UINavigationController(
            rootViewController: viewController)
        
        // Categories
        let categoriesVC = CategoriesViewController()
        categoriesVC.tabBarItem.title = "Categories"
        categoriesVC.tabBarItem.image = UIImage(systemName: "list.bullet.indent")
        let categoriesNC = UINavigationController(rootViewController: categoriesVC)
        
        
        // Main
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navigationController, categoriesNC]
        tabBarController.selectedIndex = 0
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
    }
}
