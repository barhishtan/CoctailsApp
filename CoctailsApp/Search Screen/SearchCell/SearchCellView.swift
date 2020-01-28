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

class SearchCellView: UITableViewCell {
    // MARK: - UI Properties
    private let cocktailNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let cocktailImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    // MARK: - Public Properties
    var viewModel: SearchCellViewModel?
    
    // MARK: - Private Properties
    let bag = DisposeBag()
    
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
//        contentView.snp.makeConstraints { make in
//            make.height.equalTo(80)
//        }
        
        cocktailImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(contentView.snp.height)
        }
        
        cocktailNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(cocktailImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        guard let viewModel = viewModel else { return }
//        viewModel.coctailName
//            .asDriver()
//            .drive(onNext: { [weak self] name in
//                self?.cocktailNameLabel.text = name
//            })
//            .disposed(by: bag)
        viewModel
            .coctailName
            .bind(to: cocktailNameLabel.rx.text)
            .disposed(by: bag)
        
//        viewModel
//            .coctailImageURL
//            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
//            .map { stringURL  -> UIImage in
//                guard let url = URL(string: stringURL ?? "") else { return UIImage() }
//                guard let data = try? Data(contentsOf: url) else { return UIImage() }
//                guard let image = UIImage(data: data) else { return UIImage() }
//                return image
//            }
//            .observeOn(MainScheduler.instance)
//            .bind(to: cocktailImageView.rx.image)
//        .disposed(by: bag)
    }
}
