//
//  ViewController.swift
//  Cocktails
//
//  Created by Artur Sokolov on 25.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchViewController: UITableViewController {
    
    // MARK: - UI Properties
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = ["Name", "Ingredient"]
        searchController.searchBar.returnKeyType = .done
        return searchController
    }()
    
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Private Properties
    private let bag = DisposeBag()
    
    // MARK: - Public Properties
    var viewModel: SearchViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.register(SearchCellView.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 80
        
        setupUI()
        setupBindings()
    }
    
    override func viewWillLayoutSubviews() {
        <#code#>
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        tableView.backgroundColor = .white
        
        navigationItem.title = "Search Cocktails🍸"
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8986515411)
        
        let barButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.setRightBarButton(barButton, animated: true)
    }
    
    private func setupBindings() {
        guard let viewModel = viewModel else { return }
        
        searchController.searchBar.rx.text
            .bind(to: viewModel.searchText)
            .disposed(by: bag)
        
        searchController.searchBar.rx.selectedScopeButtonIndex
            .map { index -> NetworkRouter.SearchType in
                if index == 0 { return .byName}
                else { return .byIngredient }
            }
            .bind(to: viewModel.searchType)
            .disposed(by: bag)
        
        tableView.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.selectedIndex)
            .disposed(by: bag)
        
        viewModel.showActivityIndicator
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: bag)
        
        viewModel.tableViewItems
            .bind(to: tableView.rx.items) { (tableView, row, item) in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "cell",
                    for: indexPath ) as? SearchCellView
                    else { return UITableViewCell() }
             
                cell.viewModel = item
                return cell
            }
            .disposed(by: bag)
    }
    
}

