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

final class SearchViewController: UIViewController {
    
    // MARK: - UI Properties
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = ["Name", "Ingredient"]
        searchController.searchBar.returnKeyType = .done
        return searchController
    }()
    
    private let activityIndicator = UIActivityIndicatorView()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchCellView.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        return tableView
    }()
    
    
    // MARK: - Private Properties
    private let bag = DisposeBag()
    
    // MARK: - Public Properties
    var viewModel: SearchViewModelType!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        setupBindings()
    }
    
    // MARK: - Private Methods
    private func setupNavigationBar() {
        navigationItem.title = "Search Cocktails🍸"
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8986515411)
        
        let barButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.setRightBarButton(barButton, animated: true)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
            .map { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
                return indexPath.row
            }
            .bind(to: viewModel.selectedIndex)
            .disposed(by: bag)
        
        viewModel.showActivityIndicator
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: bag)
        
        viewModel.tableViewItems
            .bind(to: tableView.rx.items(cellIdentifier: "cell",
                                         cellType: SearchCellView.self))
            { (row: Int, element: SearchCellViewModel, cell: SearchCellView) in
                cell.viewModel.accept(element)
            }
            .disposed(by: bag)
    }
    
}

