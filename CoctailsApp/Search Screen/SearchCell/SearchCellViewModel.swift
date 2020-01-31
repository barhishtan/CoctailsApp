//
//  SearchCellViewModel.swift
//  Cocktails
//
//  Created by Artur Sokolov on 28.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

protocol SearchCellViewModelType {
    var cocktailName: String? { get }
    var cocktailImageURL: String? { get }
}

final class SearchCellViewModel: SearchCellViewModelType {
    var cocktailName: String? { return cocktail.name }
    var cocktailImageURL: String? { return cocktail.imageURL }
    
    private let cocktail: Cocktail
    
    init(_ cocktail: Cocktail) {
        self.cocktail = cocktail
    }
}
