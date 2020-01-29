//
//  DetailRouter.swift
//  CoctailsApp
//
//  Created by Artur Sokolov on 29.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import UIKit

class DetailRouter {
    
    weak var baseViewController: UIViewController?
    
    enum PresentationContext {
        case view(CocktailId)
    }
    
    func present(on baseVS: UIViewController, context: Any?) {
        guard let context = context as? PresentationContext else { return }
        
        switch context {
        case .view(let coctailId):
            let viewController = DetailViewController()
            let viewModel = DetailViewModel(router: self, cocktailId: coctailId)
            viewController.viewModel = viewModel
            baseVS.navigationController?.pushViewController(viewController, animated: true)
            baseViewController = baseVS
        }
    }
}
