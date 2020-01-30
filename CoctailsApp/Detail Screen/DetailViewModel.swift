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

final class DetailViewModel {
    // MARK: - Public Properties
    let router: DetailRouter
    
    let title = PublishRelay<String?>()
    let imageStringURL = PublishRelay<String?>()
    let recipeText = PublishRelay<String?>()
    let isFavourite = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Private Properties
    private let cocktailId = BehaviorRelay<CocktailId>(value: "")
    
    private let dataFetcher = NetworkDataFetcher()
    private let decoder = RxJSONDecoder()
    private let bag = DisposeBag()
    
    
    
    // MARK: - Initializers
    init(router: DetailRouter, cocktailId: CocktailId) {
        self.router = router
        self.cocktailId.accept(cocktailId)
        //проверяю есть ли обЪет с таким ID в Realm. Если есть, то Isfavourite = true
        setupBindings()
    }
    
    // MARK: - Private Methods
    private func setupBindings() {
        cocktailId
            .unwrap()
            .flatMapLatest { [weak self] id -> Observable<CocktailList> in
                guard let self = self else {
                    return Observable<CocktailList>.just(CocktailList()) }
                let data = self.dataFetcher.fetchData(searchType: .detailByID, query: id)
                print("11")
                return self.decoder
                    .decodeJSONData(type: CocktailList.self, data: data)
                    .catchErrorJustReturn(CocktailList())
            }
            .asDriver(onErrorJustReturn: CocktailList())
            .drive(onNext: { [weak self] cocktailList in
                guard let self = self else { return }
                guard let cocktail = cocktailList.cocktails.first else { return }
                self.title.accept(cocktail.name)
                self.imageStringURL.accept(cocktail.imageURL)
                let text = self.createRecipeText(cocktail: cocktail)
                self.recipeText.accept(text)
            })
            .disposed(by: bag)
        
//        isFavourite.subscribe(onNext: { [weak self] isFavourite in
//            if isFavourite {
//                realm.write
//            } else {
//                realm.delete
//            }
//            
//        })
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
