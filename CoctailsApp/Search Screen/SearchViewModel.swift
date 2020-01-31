//
//  SearchViewModel.swift
//  Cocktails
//
//  Created by Artur Sokolov on 27.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt
import RxCocoa

protocol SearchViewModelType {
    var searchText: PublishSubject<String?> { get }
    var searchType: BehaviorRelay<NetworkRouter.SearchType> { get }
    var tableViewItems: BehaviorRelay<[SearchCellViewModel]> { get }
    var selectedIndex: PublishSubject<Int> { get }
    var showActivityIndicator: BehaviorRelay<Bool> { get }
}

final class SearchViewModel: SearchViewModelType {
    // MARK: - Public Properties
    let searchText = PublishSubject<String?>()
    let searchType = BehaviorRelay<NetworkRouter.SearchType>(value: .byName)
    let tableViewItems = BehaviorRelay<[SearchCellViewModel]>(value: [])
    let selectedIndex = PublishSubject<Int>()
    let showActivityIndicator = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Private Properties
    private let router: SearchRouter
    private var searchResult = CocktailList()
    private let bag = DisposeBag()
    private let dataFetcher = NetworkDataFetcher()
    private let decoder = RxJSONDecoder()
    
    // MARK: - Initializers
    init(router: SearchRouter) {
        self.router = router
        
        setupBindings()
    }
    
    // MARK: - Private Methods
    func setupBindings() {
        searchText
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .filter { text -> Bool in
                guard let text = text else { return false }
                return text.count > 1
            }
            .unwrap()
            .flatMapLatest { [weak self] query -> Observable<CocktailList> in
                guard let self = self else {
                    return Observable<CocktailList>.just(CocktailList()) }
                self.showActivityIndicator.accept(true)
                let data = self.dataFetcher.fetchData(searchType: self.searchType.value, query: query)
                return self.decoder
                    .decodeJSONData(type: CocktailList.self, data: data)
                    .catchErrorJustReturn(CocktailList())
            }
            .asDriver(onErrorJustReturn: CocktailList())
            .drive(onNext: { [weak self] coctailList in
                self?.showActivityIndicator.accept(false)
                self?.searchResult = coctailList
                self?.tableViewItems.accept(
                    coctailList.cocktails.map { cocktail in
                        return SearchCellViewModel(cocktail)
                    }
                )
            })
            .disposed(by: bag)
        
        selectedIndex
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                let cocktail = self.searchResult.cocktails[index]
                let cocktailId = cocktail.id
                self.router.enqueueRoute(with: SearchRouter.RouteType.details(cocktailId))
            })
            .disposed(by: bag)
    }
}
