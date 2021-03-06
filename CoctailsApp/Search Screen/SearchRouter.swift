//
//  SearchRouter.swift
//  Cocktails
//
//  Created by Artur Sokolov on 27.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import UIKit

final class SearchRouter {
    
    weak var baseViewController: UIViewController?
    
    enum RouteType {
        case details(CocktailId)
    }
    
    func enqueueRoute(with context: Any?) {
        guard let routeType = context as? RouteType else { return }
        guard let baseViewController = baseViewController else { return }
        
        switch routeType {
        case .details(let cocktailId) :
            let router = DetailRouter()
            let context = DetailRouter.PresentationContext.view(cocktailId)
            router.present(on: baseViewController, context: context)
        }
    }
}
