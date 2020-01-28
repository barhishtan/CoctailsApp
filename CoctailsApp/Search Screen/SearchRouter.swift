//
//  SearchRouter.swift
//  Cocktails
//
//  Created by Artur Sokolov on 27.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import UIKit

class SearchRouter {
    
    enum RouteType {
        case details(Cocktail)
    }
    
    weak var baseViewController: UIViewController?
    
    func enqueueRoute(with context: Any?) {
        guard let routeType = context as? RouteType else { return }
        guard let baseViewController = baseViewController else { return }
        
        switch routeType {
        case .details(let cocktail) :
            break
        }
    }
}
