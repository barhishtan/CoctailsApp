//
//  SearchCellViewModel.swift
//  Cocktails
//
//  Created by Artur Sokolov on 28.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//
import Foundation
import RxSwift
import RxCocoa

class SearchCellViewModel {
    let coctailName = BehaviorRelay<String?>(value: "...")
    let coctailImageURL = BehaviorRelay<String?>(value: "...")
    
    init(_ coctail: Cocktail) {
        coctailName.accept(coctail.name)
        coctailImageURL.accept(coctail.imageURL)
    }
}
