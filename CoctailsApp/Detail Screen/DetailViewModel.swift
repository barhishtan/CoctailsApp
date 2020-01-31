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

protocol DetailViewModelType {
    var title: PublishRelay<String?> { get }
    var imageStringURL: PublishRelay<String?> { get }
    var recipeText: PublishRelay<String?> { get }
    var isFavourite: BehaviorRelay<Bool> { get }
}

final class DetailViewModel: DetailViewModelType {
    // MARK: - Public Properties
    let title = PublishRelay<String?>()
    let imageStringURL = PublishRelay<String?>()
    let recipeText = PublishRelay<String?>()
    let isFavourite = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Private Properties
    private let router: DetailRouter
    private let cocktailId: BehaviorRelay<CocktailId>
    private var cocktail = Cocktail()
    private let dataFetcher = NetworkDataFetcher()
    private let decoder = RxJSONDecoder()
    private let storage = PersistenceStorage()
    private let bag = DisposeBag()
    
    // MARK: - Initializers
    init(router: DetailRouter, cocktailId: CocktailId) {
        self.router = router
        self.cocktailId = BehaviorRelay<CocktailId>(value: cocktailId)
        
        isFavouriteCheck()
        setupBindings()
    }
    
    // MARK: - Private Methods
    private func isFavouriteCheck() {        
        guard let key = cocktailId.value else { return }
        if storage.containsObject(ofType: Cocktail.self, key: key) {
            isFavourite.accept(true)
        }
    }
    
    private func setupBindings() {
        cocktailId
            .unwrap()
            .flatMap { [weak self] id -> Observable<CocktailList> in
                guard let self = self else {
                    return Observable<CocktailList>.just(CocktailList()) }
                let data = self.dataFetcher.fetchData(searchType: .detailByID, query: id)
                return self.decoder
                    .decodeJSONData(type: CocktailList.self, data: data)
                    .catchErrorJustReturn(CocktailList())
            }
            .asDriver(onErrorJustReturn: CocktailList())
            .drive(onNext: { [weak self] cocktailList in
                guard let self = self else { return }
                guard let cocktail = cocktailList.cocktails.first else { return }
                self.cocktail = cocktail
                self.title.accept(cocktail.name)
                self.imageStringURL.accept(cocktail.imageURL)
                let text = self.createRecipeText(cocktail: cocktail)
                self.recipeText.accept(text)
            })
            .disposed(by: bag)
        
        isFavourite.subscribe(onNext: { [weak self] isFavourite in
            guard let self = self else { return }
            if isFavourite {
                let cocktail = self.cocktail.copy() as! Cocktail
                if cocktail.name != nil { self.storage.save(cocktail) }
            } else {
                guard let cocktail = self.storage.fetchObject(ofType: Cocktail.self, key: self.cocktailId.value ?? "") else { return }
                self.storage.delete(cocktail)
            }
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
