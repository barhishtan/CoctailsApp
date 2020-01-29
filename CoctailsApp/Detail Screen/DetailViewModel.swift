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
    
    let title: BehaviorRelay<String?>
    let imageStringURL: BehaviorRelay<String?>
    let recipeText: BehaviorRelay<String?>
    let isFavourite = PublishSubject<Bool>()
    
    // MARK: - Initializers
    init(router: DetailRouter, cocktail: Cocktail) {
        self.router = router
        let text = DetailViewModel.createRecipeText(cocktail: cocktail)
        
        title = BehaviorRelay<String?>(value: cocktail.name)
        imageStringURL = BehaviorRelay<String?>(value: cocktail.imageURL)
        recipeText = BehaviorRelay<String?>(value: text)
    }
    
    // MARK: - Private Methods
    private static func createRecipeText(cocktail: Cocktail) -> String? {
        var text = "Instructions: \n\n"
        text.append("\(cocktail.instructions ?? "") \n\n")
        text.append("Ingredients: \n\n")
        text.append("\(cocktail.ingredientOne ?? "")   \(cocktail.measureOne ?? "") \n")
        text.append("\(cocktail.ingredientTwo ?? "")   \(cocktail.measureTwo ?? "") \n")
        text.append("\(cocktail.ingredientThree ?? "")   \(cocktail.measureThree ?? "") \n")
        text.append("\(cocktail.ingredientFour ?? "")   \(cocktail.measureFour ?? "") \n")
        text.append("\(cocktail.ingredientFive ?? "")   \(cocktail.measureFive ?? "") \n")
        text.append("\(cocktail.ingredientSix ?? "")   \(cocktail.measureSix ?? "") \n")
        text.append("\(cocktail.ingredientSeven ?? "")   \(cocktail.measureSeven ?? "") \n")
        text.append("\(cocktail.ingredientEight ?? "")   \(cocktail.ingredientEight ?? "") \n")
        text.append("\(cocktail.ingredientNine ?? "")   \(cocktail.measureNine ?? "") \n")
        text.append("\(cocktail.ingredientTen ?? "")   \(cocktail.measureTen ?? "") \n")
        return text
    }
}
