//
//  SearchRouter.swift
//  Cocktails
//
//  Created by Artur Sokolov on 27.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import UIKit

class SearchRouter {
    
    weak var baseViewController: UIViewController?
    
    enum RouteType {
        case details(Cocktail)
    }
    
    func enqueueRoute(with context: Any?) {
        guard let routeType = context as? RouteType else { return }
        guard let baseViewController = baseViewController else { return }
        
        switch routeType {
        case .details(let cocktail) :
            let router = DetailRouter()
            let context = DetailRouter.PresentationContext.view(cocktail)
            router.present(on: baseViewController, context: context)
        }
    }
}
