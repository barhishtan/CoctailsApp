//
//  FavouritesRouter.swift
//  CoctailsApp
//
//  Created by Artur Sokolov on 30.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import UIKit

final class FavouritesRouter {
    weak var baseViewController: UIViewController?
    
    enum RouteType {
        case details(CocktailId)
    }
    
    func enqueueRoute(with context: Any?) {
        guard let baseViewController = baseViewController else { return }
        guard let context = context as? RouteType else { return }
        
        switch context {
        case .details(let id):
            let router = DetailRouter()
            let context = DetailRouter.PresentationContext.view(id)
            router.present(on: baseViewController, context: context)
        }
    }
}
