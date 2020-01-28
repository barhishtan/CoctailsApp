//
//  NetworkImage.swift
//  CoctailsApp
//
//  Created by Artur Sokolov on 28.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import Foundation

class NetworkImage {
    func getImageData(from stringURL: String?) -> Data? {
        guard let stringURL = stringURL else { return nil }
        guard let url = URL(string: stringURL) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return data
    }
}
