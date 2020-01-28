//
//  SearchCellViewModel.swift
//  Cocktails
//
//  Created by Artur Sokolov on 28.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//
import Foundation

class SearchCellViewModel {
    var cocktailName: String? { return cocktail.name }
    var cocktailImageData: Data? {
        return NetworkImage().getImageData(from: "\(cocktail.imageURL ?? "")/preview")
    }
    
    private let cocktail: Cocktail
    
    init(_ cocktail: Cocktail) {
        self.cocktail = cocktail
    }
}
