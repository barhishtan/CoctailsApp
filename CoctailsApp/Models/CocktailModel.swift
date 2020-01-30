//
//  CocktailModel.swift
//  Cocktails
//
//  Created by Artur Sokolov on 27.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import Foundation
import RealmSwift

typealias CocktailId = String?

final class Cocktail: Object, Decodable {
    // MARK: - Public Properties
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var instructions: String?
    @objc dynamic var imageURL: String?
    
    @objc dynamic var ingredientOne: String?
    @objc dynamic var ingredientTwo: String?
    @objc dynamic var ingredientThree: String?
    @objc dynamic var ingredientFour: String?
    @objc dynamic var ingredientFive: String?
    @objc dynamic var ingredientSix: String?
    @objc dynamic var ingredientSeven: String?
    @objc dynamic var ingredientEight: String?
    @objc dynamic var ingredientNine: String?
    @objc dynamic var ingredientTen: String?
    
    @objc dynamic var measureOne: String?
    @objc dynamic var measureTwo: String?
    @objc dynamic var measureThree: String?
    @objc dynamic var measureFour: String?
    @objc dynamic var measureFive: String?
    @objc dynamic var measureSix: String?
    @objc dynamic var measureSeven: String?
    @objc dynamic var measureEigth: String?
    @objc dynamic var measureNine: String?
    @objc dynamic var measureTen: String?
    
    // MARK: - Private Methods
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: - CodingKeys
    private enum CodingKeys: String, CodingKey {
        
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
final class CocktailList: Object, Decodable {
    var cocktails = List<Cocktail>()
    
    private enum CodingKeys: String, CodingKey {
        case cocktails = "drinks"
    }
}
