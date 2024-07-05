//
//  SearchViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 26.03.2024.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: Private Properties
    private var viewModel: SearchViewModelProtocol
    
    // MARK: Views
    private lazy var filtersButton: NavigationBarButton = {
        let button = NavigationBarButton(
            image: Constants.Images.ButtonImages.filters)
        button.addTarget(
            self,
            action: #selector(filtersButtonTapped),
            for: .touchUpInside)
        return button
    }()
    private lazy var relatedButton: NavigationBarButton = {
        let button = NavigationBarButton(
            image: Constants.Images.ButtonImages.related)
        button.addTarget(
            self,
            action: #selector(relatedButtonTapped),
            for: .touchUpInside)
        return button
    }()
    private lazy var featuresButton: NavigationBarButton = {
        let button = NavigationBarButton(
            image: Constants.Images.ButtonImages.features)
        button.addTarget(
            self,
            action: #selector(featuresButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.searchTextField.backgroundColor = .lightGray
        searchController.searchBar.tintColor = .white
        let placeholder = Constants.Text.Placeholders.startTyping
        searchController.searchBar.placeholder = placeholder
        searchController.searchBar.autocorrectionType = .no
        searchController.searchBar.spellCheckingType = .no
        return searchController
    }()
    
    private lazy var searchTipsView = SearchTipsView(
        isFullSet: viewModel.isEditingAllowed)
    
    // MARK: Initialize
    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        setupNavigationBar()
        view.setupGradientLayer()
        view.addSubview(searchTipsView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: filtersButton),
            UIBarButtonItem(customView: featuresButton)
        ]
        if viewModel.isEditingAllowed {
            navigationItem.rightBarButtonItems?.insert(
                UIBarButtonItem(customView: relatedButton),
                at: 1)
        }
        navigationItem.searchController = searchController
    }
    
    private func toggleStatus(_ sender: UIButton) {
        sender.isSelected.toggle()
        sender.tintColor = sender.isSelected ? .systemGreen : .white
    }
    
    @objc private func filtersButtonTapped(_ sender: UIButton) {
        let filtersVC = ScreenFactory.getFiltersViewController()
        present(filtersVC, animated: true)
    }
    
    @objc private func relatedButtonTapped(_ sender: UIButton) {
        toggleStatus(sender)
        
    }
    
    @objc private func featuresButtonTapped(_ sender: UIButton) {
        toggleStatus(sender)
        
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
