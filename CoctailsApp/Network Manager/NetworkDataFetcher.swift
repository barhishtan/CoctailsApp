//
//  NetworkDataFetcher.swift
//  Cocktails
//
//  Created by Artur Sokolov on 27.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import Foundation
import RxSwift

final class NetworkDataFetcher {
    private let networkRouter = NetworkRouter()
    
    func fetchData(searchType: NetworkRouter.SearchType, query: String? = nil) -> Observable<Data> {
        let request = URLRequest(url: networkRouter.buildURL(type: searchType, query: query))
        let data = URLSession.shared.rx
            .data(request: request)
        return data
    }
}
