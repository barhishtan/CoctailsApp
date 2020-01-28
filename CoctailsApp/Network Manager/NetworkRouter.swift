//
//  NetworkDataFetcher.swift
//  Cocktails
//
//  Created by Artur Sokolov on 26.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import Foundation

class NetworkRouter {
    // MARK: - Private Properties
    static private let baseURL: URLComponents = {
        var baseURL = URLComponents()
        baseURL.scheme = "https"
        baseURL.host = "www.thecocktaildb.com"
        baseURL.path = "/api/json/v1/1/"
        return baseURL
    }()
    
    // MARK: - SearchType
    enum SearchType: RawRepresentable {
        case byName
        case byIngredient
        case byCategory
        case detailByID
        case categoriesList
        case random
        
        var rawValue: (String, String) {
            switch self {
            case .byName: return ("search.php", "s")
            case .byIngredient: return ("filter.php", "i")
            case .byCategory: return ("filter.php", "c")
            case .detailByID: return ("lookup.php", "i")
            case .categoriesList: return ("list.php", "c")
            case .random: return ("random.php", "")
            }
        }
        
        init?(rawValue: (String, String)) {
            switch rawValue {
            case ("search.php", "s"): self = .byName
            case ("filter.php", "i"): self = .byIngredient
            case ("filter.php", "c"): self = .byCategory
            case ("lookup.php", "i"): self = .detailByID
            case ("list.php", "c"): self = .categoriesList
            case ("random.php", ""): self = .random
            default: return nil
            }
        }
    }
    // MARK: - Public Methods
    func buildURL(type: SearchType, query: String? = nil) -> URL {
        
        var baseURL = NetworkRouter.baseURL
        baseURL.path += type.rawValue.0
        
        if type == .random { return baseURL.url!}
        if type == .categoriesList {
            baseURL.queryItems = [URLQueryItem(name: type.rawValue.1, value: "list")]
            return baseURL.url!
        }
        
        baseURL.queryItems = [URLQueryItem(name: type.rawValue.1, value: query)]
        return baseURL.url!
    }
}
