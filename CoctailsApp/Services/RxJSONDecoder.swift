//
//  RxJSONDecoder.swift
//  Cocktails
//
//  Created by Artur Sokolov on 27.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import Foundation
import RxSwift

final class RxJSONDecoder {
    func decodeJSONData<T: Decodable>(type: T.Type, data: Observable<Data>) -> Observable<T> {
        return data.map { data in
            return try JSONDecoder().decode(type.self, from: data)
        }
    }
}

