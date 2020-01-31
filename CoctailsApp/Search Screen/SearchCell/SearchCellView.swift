//
//  SearchCellView.swift
//  Cocktails
//
//  Created by Artur Sokolov on 28.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchCellView: UITableViewCell {
    // MARK: - UI Properties
    private let cocktailNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let cocktailImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    // MARK: - Public Properties
    let viewModel = PublishRelay<SearchCellViewModelType>()
    
    // MARK: - Private Properties
    private let bag = DisposeBag()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        contentView.addSubview(cocktailNameLabel)
        contentView.addSubview(cocktailImageView)
    }
    
    private func setupConstraints() {
        cocktailImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(1)
            make.bottom.equalToSuperview().inset(1)
            make.width.equalTo(contentView.snp.height)
        }
        
        cocktailNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(cocktailImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        viewModel.subscribe(onNext: { [weak self] viewModel in
            self?.cocktailNameLabel.text = viewModel.cocktailName
            self?.cocktailImageView.fetchImage(fromURL: viewModel.cocktailImageURL)
        })
        .disposed(by: bag)
        
    }
    
}
