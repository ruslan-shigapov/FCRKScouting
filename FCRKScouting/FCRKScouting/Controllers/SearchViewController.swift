//
//  SearchViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 26.03.2024.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: Private Properties
    private var searchTimer: Timer?
    private var viewModel: SearchViewModelProtocol
    
    private lazy var collectionViewDelegate = SearchCollectionDelegate(
        navigationController: navigationController,
        viewModel: viewModel)
    private lazy var collectionViewDataSource = SearchCollectionDataSource(
        viewModel: viewModel)
    
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
        button.tag = 1
        button.addTarget(
            self,
            action: #selector(relatedButtonTapped),
            for: .touchUpInside)
        return button
    }()
    private lazy var favoritesButton: NavigationBarButton = {
        let button = NavigationBarButton(
            image: Constants.Images.ButtonImages.favorites)
        button.tag = 0
        button.addTarget(
            self,
            action: #selector(favoritesButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        let searchBar = searchController.searchBar
        searchBar.placeholder = Constants.Texts.Placeholders.startTyping
        searchBar.spellCheckingType = .no
        searchBar.autocorrectionType = .no
        let backgroundColor = UIColor.white.withAlphaComponent(0.6)
        searchBar.searchTextField.backgroundColor = backgroundColor
        return searchController
    }()
    
    private lazy var playerCollectionView: PlayerCollectionView = {
        let collectionView = PlayerCollectionView()
        collectionView.delegate = collectionViewDelegate
        collectionView.dataSource = collectionViewDataSource
        collectionView.register(
            PlayerCollectionViewCell.self,
            forCellWithReuseIdentifier: String(
                describing: PlayerCollectionViewCell.self))
        return collectionView
    }()
    
    private lazy var searchTipsView = SearchTipsView(
        isFullSet: viewModel.isEditingAllowed)
    
    private let noResultsLabel: DefaultTextLabel = {
        let label = DefaultTextLabel(text: Constants.Texts.noSearchResults)
        label.textColor = .white
        label.isHidden = true
        return label
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.hidesWhenStopped = true
        indicatorView.color = .black
        return indicatorView
    }()
    
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
        handleExtraFiltersChange()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        setupNavigationBar()
        view.setupGradientLayer()
        view.addSubviews(
            searchTipsView,
            noResultsLabel,
            playerCollectionView,
            activityIndicator)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func handleExtraFiltersChange() {
        viewModel.extraFiltersWareChanged = { [weak self] in
            guard let self else { return }
            viewModel.extraFiltersValue.toggle()
            filtersButton.tintColor = viewModel.extraFiltersValue
            ? .systemGreen
            : .white
            viewModel.getRequiredPlayers()
            searchTipsView.isHidden = !viewModel.hasNoResults
            playerCollectionView.reloadData()
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: filtersButton),
            UIBarButtonItem(customView: favoritesButton)
        ]
        if viewModel.isEditingAllowed {
            navigationItem.rightBarButtonItems?.insert(
                UIBarButtonItem(customView: relatedButton),
                at: 1)
        }
        navigationItem.searchController = searchController
        let barButtonAppearance = UIBarButtonItem.appearance(
            whenContainedInInstancesOf: [UISearchBar.self])
        barButtonAppearance.setTitleTextAttributes(
            [.foregroundColor: UIColor.white],
            for: .normal)
    }
    
    private func toggleStatus(_ sender: UIButton) {
        sender.isSelected.toggle()
        sender.tintColor = sender.isSelected ? .systemGreen : .white
    }
    
    private func setupFilterMode(with sender: UIButton)  {
        toggleStatus(sender)
        if sender.isSelected {
            viewModel.toggleFilter(byTag: sender.tag)
            viewModel.getRequiredPlayers()
            playerCollectionView.reloadData()
        } else {
            viewModel.toggleFilter(byTag: sender.tag)
            viewModel.getRequiredPlayers()
            playerCollectionView.reloadData()
            searchTipsView.isHidden = !viewModel.isFiltersInactive
        }
        searchTipsView.isHidden = !viewModel.hasNoResults
    }
    
    @objc private func filtersButtonTapped(_ sender: UIButton) {
        let filtersVC = ScreenFactory.getFiltersViewController(
            withDelegate: viewModel as FiltersViewControllerDelegate,
            andFiltersValue: viewModel.extraFiltersValue)
        if let sheet = filtersVC.sheetPresentationController {
            sheet.prefersGrabberVisible = true
        }
        present(filtersVC, animated: true)
    }
    
    @objc private func relatedButtonTapped(_ sender: UIButton) {
        setupFilterMode(with: sender)
    }
    
    @objc private func favoritesButtonTapped(_ sender: UIButton) {
        setupFilterMode(with: sender)
    }
}

// MARK: - Search Results Updating
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text,
              !searchText.isEmpty else {
            viewModel.returnOriginalPlayers()
            playerCollectionView.reloadData()
            noResultsLabel.isHidden = true
            return
        }
        searchTipsView.isHidden = true
        if !searchText.isEmpty {
            noResultsLabel.isHidden = true
            activityIndicator.startAnimating()
        }
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(
            withTimeInterval: 0.5,
            repeats: false,
            block: { [weak self] _ in
                guard let self else { return }
                viewModel.findPlayers(byText: searchText) {
                    self.noResultsLabel.isHidden = !self.viewModel.hasNoResults
                    self.playerCollectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            })
    }
}

// MARK: - Search Bar Delegate
extension SearchViewController: UISearchControllerDelegate {
    
    func willDismissSearchController(_ searchController: UISearchController) {
        noResultsLabel.isHidden = true
        viewModel.cancelSearch()
        playerCollectionView.reloadData()
        searchTipsView.isHidden = !viewModel.hasNoResults
    }
}

// MARK: - Layout
extension SearchViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchTipsView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            searchTipsView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
            
            noResultsLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
            
            playerCollectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            playerCollectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
            playerCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(
                equalTo: view.centerYAnchor)
        ])
    }
}
