//
//  SceneDelegate.swift
//  CoctailsApp
//
//  Created by Artur Sokolov on 28.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let coordinator = Coordinator()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
  
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        coordinator.presentInitialScreen(on: window ?? UIWindow())
    }

}

