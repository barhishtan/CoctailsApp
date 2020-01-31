//
//  Coordinator.swift
//  CoctailsApp
//
//  Created by Artur Sokolov on 28.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import UIKit

final class Coordinator {
    
    func presentInitialScreen(on window: UIWindow) {
        // MARK: - Search
        let router = SearchRouter()
        let viewModel = SearchViewModel(router: router)
        let viewController = SearchViewController()
        
        viewController.viewModel = viewModel
        viewController.tabBarItem.title = "Search"
        viewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        router.baseViewController = viewController
        
        let navigationController = UINavigationController(
            rootViewController: viewController)
        
        // MARK: - Favourites
        let favouritesRouter = FavouritesRouter()
        let favouritesViewModel = FavouritesViewModel(router: favouritesRouter)
        let favouritesVC = FavouritesViewController()
        
        favouritesVC.viewModel = favouritesViewModel
        favouritesVC.tabBarItem.title = "Favourites"
        favouritesVC.tabBarItem.image = UIImage(systemName: "star.fill")
        favouritesRouter.baseViewController = favouritesVC
        
        let favouritesNC = UINavigationController(
            rootViewController: favouritesVC)
        
        // MARK: - Main
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navigationController, favouritesNC]
        tabBarController.selectedIndex = 0
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

    }
}
