//
//  FavouritesViewModel.swift
//  CoctailsApp
//
//  Created by Artur Sokolov on 30.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import RxSwift
import RxCocoa
import RxRealm

protocol FavouritesViewModelType {
    var tableViewItems: BehaviorRelay<[SearchCellViewModel]> { get }
    var selectedIndex: PublishRelay<Int> { get }
}

final class FavouritesViewModel: FavouritesViewModelType {
    
    // MARK: - Private Properties
    private let router: FavouritesRouter
    private let bag = DisposeBag()
    private let storage = PersistenceStorage()
    private var cocktails = [Cocktail]()
    
    // MARK: - Public Properties
    let tableViewItems = BehaviorRelay<[SearchCellViewModel]>(value: [])
    let selectedIndex = PublishRelay<Int>()
    
    // MARK: - Initializers
    init(router: FavouritesRouter) {
        self.router = router
        
        setupBindings()
    }
    
    // MARK: - Private Methods
    private func setupBindings() {
        
        let results = storage.fetchObjects(ofType: Cocktail.self)
        
        Observable.collection(from: results)
            .map { [weak self] result -> [SearchCellViewModel] in
                guard let self = self else { return [SearchCellViewModel]() }
                self.cocktails = result.toArray()
                return self.cocktails.map { SearchCellViewModel($0) }
            }
            .subscribe(onNext: { [weak self] array in
                self?.tableViewItems.accept(array)
            })
            .disposed(by: bag)
          
          selectedIndex
          .subscribe(onNext: { [weak self] index in
              guard let self = self else { return }
              let cocktail = self.cocktails[index]
              let cocktailId = cocktail.id
              self.router.enqueueRoute(with: FavouritesRouter.RouteType.details(cocktailId))
          })
          .disposed(by: bag)
    }
    
}
