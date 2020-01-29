//
//  DetailViewModel.swift
//  CoctailsApp
//
//  Created by Artur Sokolov on 29.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel {
    // MARK: - Public Properties
    let router: DetailRouter
    
    let title = PublishRelay<String?>()
    let imageStringURL = PublishRelay<String?>()
    let recipeText = PublishRelay<String?>()
    let isFavourite = PublishRelay<Bool>()
    
    // MARK: - Private Properties
    let bag = DisposeBag()
    let cocktail: Cocktail
    
    // MARK: - Initializers
    init(router: DetailRouter, cocktail: Cocktail) {
        self.router = router
        self.cocktail = cocktail
        
        setupBindings()
    }
    
    // MARK: - Private Methods
    private func setupBindings() {
        title.accept(cocktail.name)
        imageStringURL.accept(cocktail.imageURL)
        recipeText.accept(createRecipeText())
    }
    
    private func createRecipeText() -> String? {
        var text = "Instructions: \n"
        text.append(cocktail.instructions ?? "")
        text.append("\n Ingredients: \n")
        text.append("\(cocktail.ingredientOne ?? "") - \(cocktail.measureOne ?? "") \t")
        text.append("\(cocktail.ingredientTwo ?? "") - \(cocktail.measureTwo ?? "") \t")
        text.append("\(cocktail.ingredientThree ?? "") - \(cocktail.measureThree ?? "") \t")
        text.append("\(cocktail.ingredientFour ?? "") - \(cocktail.measureFour ?? "") \t")
        text.append("\(cocktail.ingredientFive ?? "") - \(cocktail.measureFive ?? "") \t")
        text.append("\(cocktail.ingredientSix ?? "") - \(cocktail.measureSix ?? "") \t")
        text.append("\(cocktail.ingredientSeven ?? "") - \(cocktail.measureSeven ?? "") \t")
        text.append("\(cocktail.ingredientEight ?? "") - \(cocktail.ingredientEight ?? "") \t")
        text.append("\(cocktail.ingredientNine ?? "") - \(cocktail.measureNine ?? "") \t")
        text.append("\(cocktail.ingredientTen ?? "") - \(cocktail.measureTen ?? "") \t")
        return text
    }
}
