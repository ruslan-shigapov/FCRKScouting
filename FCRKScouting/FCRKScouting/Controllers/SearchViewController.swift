//
//  SearchViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 26.03.2024.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private var viewModel: SearchViewModelProtocol
    
    private let searchTipsView = SearchTipsView()
    
    // MARK: Initialize
    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupNavigationBarButton()
        
        let sc = UISearchController()
        sc.searchBar.searchTextField.backgroundColor = .white
        sc.searchBar.tintColor = .lightGray
        sc.searchBar.placeholder = "Начните вводить"
        navigationItem.searchController = sc
        
        view.setupCommonGradientLayer()
        view.addSubview(searchTipsView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setupNavigationBarButton() {
        let filtersButton = CustomNavigationBarButton(
            image: Constants.Images.ButtonImages.filters)
        filtersButton.addTarget(
            self,
            action: #selector(changeFiltersButtonTapped),
            for: .touchUpInside)
        let relatedButton = CustomNavigationBarButton(
            image: Constants.Images.ButtonImages.related)
        let featuresButton = CustomNavigationBarButton(
            image: Constants.Images.ButtonImages.features)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: filtersButton),
            UIBarButtonItem(customView: relatedButton),
            UIBarButtonItem(customView: featuresButton)
        ]
        
        // TODO: добавить green статус фильтрам или возможно менять кнопки тоже
    }
    
    @objc private func changeFiltersButtonTapped() {
        let filtersVC = ScreenFactory.getFiltersViewController()
        present(filtersVC, animated: true)
    }
}

// MARK: - Layout
private extension SearchViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            searchTipsView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            searchTipsView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
