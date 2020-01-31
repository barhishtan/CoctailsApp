//
//  CategoriesViewController.swift
//  CoctailsApp
//
//  Created by Artur Sokolov on 28.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class FavouritesViewController: UIViewController {
    
    // MARK: - UI Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchCellView.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .white
        tableView.rowHeight = 100
        return tableView
    }()
    // MARK: - Properties
    private let bag = DisposeBag()
    var viewModel: FavouritesViewModelType!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        setupBindings()
    }
    
    // MARK: - Private Methods
    private func setupNavigationBar() {
        navigationItem.title = "Favourite Cocktails🍸"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8986515411)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        
        tableView.rx.itemSelected
            .map { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
                return indexPath.row
            }
            .bind(to: viewModel.selectedIndex)
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
