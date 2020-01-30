//
//  DetailViewController.swift
//  CoctailsApp
//
//  Created by Artur Sokolov on 29.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

 final class DetailViewController: UIViewController {
    // MARK: - UI Properties
    let detailImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let favoriteLabel: UILabel = {
        let label = UILabel()
        label.text = "Is favorite 👍🏻"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let favoriteSwitch: UISwitch = {
        let favoriteSwitch = UISwitch()
        return favoriteSwitch
    }()
    
    let recipeTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 20, weight: .semibold)
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.scrollRangeToVisible(NSRange(location: 0, length: 0))
        return textView
    }()
    
    // MARK: - Properties
    var viewModel: DetailViewModel?
    private let bag = DisposeBag()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupBindings()
    
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(detailImage)
        view.addSubview(recipeTextView)
    }
    
    private func setupConstraints() {
        detailImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        recipeTextView.snp.makeConstraints { make in
            make.top.equalTo(detailImage.snp.bottom).offset(10)
            make.leading.bottom.trailing.equalToSuperview().offset(10)
        }
    }
    
    private func setupNavigationBar() {
//        navigationItem.title = "Coctail info"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8986515411)
        
        let barSwitch = UIBarButtonItem(customView: favoriteSwitch)
        let barLabel = UIBarButtonItem(customView: favoriteLabel)
        navigationItem.setRightBarButtonItems([barSwitch, barLabel], animated: true)
        
      }
    
    private func setupBindings() {
        guard let viewModel = viewModel else { return }
        
        favoriteSwitch.isOn = viewModel.isFavourite.value
        
        favoriteSwitch.rx.isOn
            .bind(to: viewModel.isFavourite)
            .disposed(by: bag)
        
        viewModel.recipeText
            .bind(to: recipeTextView.rx.text)
            .disposed(by: bag)
        
        viewModel.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: bag)
        
        viewModel.imageStringURL
            .subscribe(onNext: { [weak self] stringURL in
                self?.detailImage.fetchImage(fromURL: stringURL)
            })
            .disposed(by: bag)
    }
}
