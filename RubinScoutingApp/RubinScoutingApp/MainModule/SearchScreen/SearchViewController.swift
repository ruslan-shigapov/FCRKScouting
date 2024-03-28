//
//  SearchViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 26.03.2024.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let temporarySearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Начните вводить..."
        return searchBar
    }()
    
    private let emptyScreenLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Здесь будет отображаться список с результатами поиска - совпадения с учетом примененных фильтров"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(temporarySearchBar)
        view.addSubview(emptyScreenLabel)
        setupNavigationBarButton()
        setConstraints()
    }
    
    private func setupNavigationBarButton() {
        let filtersButton = NavigationBarButton(
            image: Constants.Images.ButtonImages.filters)
        filtersButton.addTarget(
            self,
            action: #selector(changeFiltersButtonTapped),
            for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: filtersButton)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func changeFiltersButtonTapped() {
        let temporaryVC = UIViewController()
        temporaryVC.view.backgroundColor = .lightGray
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Здесь будут фильтры поиска"
        label.textColor = .white
        temporaryVC.view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: temporaryVC.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: temporaryVC.view.centerYAnchor).isActive = true
        present(temporaryVC, animated: true)
    }
}

// MARK: - Layout
private extension SearchViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            temporarySearchBar.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            temporarySearchBar.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            temporarySearchBar.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
        
            
            emptyScreenLabel.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
            emptyScreenLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 40),
            emptyScreenLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -40)
        ])
    }
}
