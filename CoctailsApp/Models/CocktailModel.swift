//
//  CocktailModel.swift
//  Cocktails
//
//  Created by Artur Sokolov on 27.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import Foundation

typealias CocktailId = String?

struct Cocktail: Decodable {
    // MARK: - Public Properties
    var id: String?
    var name: String?
    var instructions: String?
    var imageURL: String?
    
    var ingredientOne: String?
    var ingredientTwo: String?
    var ingredientThree: String?
    var ingredientFour: String?
    var ingredientFive: String?
    var ingredientSix: String?
    var ingredientSeven: String?
    var ingredientEight: String?
    var ingredientNine: String?
    var ingredientTen: String?
    
    var measureOne: String?
    var measureTwo: String?
    var measureThree: String?
    var measureFour: String?
    var measureFive: String?
    var measureSix: String?
    var measureSeven: String?
    var measureEigth: String?
    var measureNine: String?
    var measureTen: String?
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        
        case id = "idDrink"
        case name = "strDrink"
        case instructions = "strInstructions"
        case imageURL = "strDrinkThumb"
        
        case ingredientOne = "strIngredient1"
        case ingredientTwo = "strIngredient2"
        case ingredientThree = "strIngredient3"
        case ingredientFour = "strIngredient4"
        case ingredientFive = "strIngredient5"
        case ingredientSix = "strIngredient6"
        case ingredientSeven = "strIngredient7"
        case ingredientEight = "strIngredient8"
        case ingredientNine = "strIngredient9"
        case ingredientTen = "strIngredient10"
        
        case measureOne = "strMeasure1"
        case measureTwo = "strMeasure2"
        case measureThree = "strMeasure3"
        case measureFour = "strMeasure4"
        case measureFive = "strMeasure5"
        case measureSix = "strMeasure6"
        case measureSeven = "strMeasure7"
        case measureEigth = "strMeasure8"
        case measureNine = "strMeasure9"
        case measureTen = "strMeasure10"
    }
}

// MARK: - CocktailList
struct CocktailList: Decodable {
    var cocktails: [Cocktail] = []
    
    enum CodingKeys: String, CodingKey {
        case cocktails = "drinks"
    }
}
