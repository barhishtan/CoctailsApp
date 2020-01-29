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
import RxSwiftExt

class DetailViewModel {
    // MARK: - Public Properties
    let router: DetailRouter
    
    let title = BehaviorRelay<String?>(value: "")
    let imageStringURL = BehaviorRelay<String?>(value: "")
    let recipeText = BehaviorRelay<String?>(value: "")
    let isFavourite = PublishRelay<Bool>()
    
    // MARK: - Private Properties
    private let cocktailId = PublishSubject<CocktailId>()
    
    private let dataFetcher = NetworkDataFetcher()
    private let decoder = RxJSONDecoder()
    private let bag = DisposeBag()
    
    
    
    // MARK: - Initializers
    init(router: DetailRouter, cocktailId: CocktailId) {
        self.router = router
        self.cocktailId.onNext(cocktailId)
//        let text = DetailViewModel.createRecipeText(cocktail: cocktail)
//
//        title = BehaviorRelay<String?>(value: cocktail.name)
//        imageStringURL = BehaviorRelay<String?>(value: cocktail.imageURL)
//        recipeText = BehaviorRelay<String?>(value: text)
        setupBindings()
    }
    
    // MARK: - Private Methods
    private func setupBindings() {
        cocktailId
            .unwrap()
            .flatMapLatest { [weak self] id -> Observable<Cocktail> in
                guard let self = self else {
                    return Observable<Cocktail>.just(Cocktail()) }
                let data = self.dataFetcher.fetchData(searchType: .detailByID, query: id)
                
                return self.decoder
                    .decodeJSONData(type: Cocktail.self, data: data)
                    .catchErrorJustReturn(Cocktail())
            }
            .asDriver(onErrorJustReturn: Cocktail())
            .drive(onNext: { [weak self] cocktail in
                guard let self = self else { return }
                self.title.accept(cocktail.name)
                self.imageStringURL.accept(cocktail.imageURL)
                let text = self.createRecipeText(cocktail: cocktail)
                self.recipeText.accept(text)
            })
            .disposed(by: bag)
    }
    
    private func createRecipeText(cocktail: Cocktail) -> String? {
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
