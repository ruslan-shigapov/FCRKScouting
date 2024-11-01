//
//  SearchViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 26.03.2024.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: Private Properties
    private let viewModel: SearchViewModel
    
    private var searchTimer: Timer?

    private lazy var collectionViewDataSource = PlayerCollectionViewDataSource(
        viewModel: viewModel)
    private lazy var collectionViewDelegate = PlayerCollectionViewDelegate(
        viewModel: viewModel,
        navigationController: navigationController)
    
    // MARK: Views
    private lazy var filtersButton: NavigationBarButton = {
        $0.addTarget(
            self,
            action: #selector(filtersButtonTapped),
            for: .touchUpInside)
        return $0
    }(NavigationBarButton(image: Constants.Images.ButtonImages.filters))
    
    private lazy var relatedButton: NavigationBarButton = {
        $0.tag = 1
        $0.addTarget(
            self,
            action: #selector(relatedButtonTapped),
            for: .touchUpInside)
        return $0
    }(NavigationBarButton(image: Constants.Images.ButtonImages.related))
    
    private lazy var favoritesButton: NavigationBarButton = {
        $0.tag = 2
        $0.addTarget(
            self,
            action: #selector(favoritesButtonTapped),
            for: .touchUpInside)
        return $0
    }(NavigationBarButton(image: Constants.Images.ButtonImages.favorites))
    
    private lazy var searchController: SearchBarController = {
        $0.searchResultsUpdater = self
        $0.delegate = self
        return $0
    }(SearchBarController())
    
    private lazy var playerCollectionView: PlayerCollectionView = {
        $0.delegate = collectionViewDelegate
        $0.dataSource = collectionViewDataSource
        return $0
    }(PlayerCollectionView())
    
    private lazy var searchTipsView = SearchTipsView(
        isFullSetRequired: viewModel.isEditingAllowed)
    
    private let noResultsLabel = NoResultsLabel(
        text: Constants.Texts.noSearchResults)
    
    private let activityIndicator = LargeActivityIndicatorView()
    
    // MARK: Initialize
    init(viewModel: SearchViewModel) {
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
        handleEvents()
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
    
    private func handleEvents() {
        viewModel.onExtraFiltersChanged = { [weak self] in
            guard let self else { return }
            viewModel.extraFiltersValue.toggle()
            filtersButton.tintColor = viewModel.extraFiltersValue
            ? .systemGreen
            : .white
            updateUI()
        }
    }
    
    private func updateUI() {
        viewModel.getRequiredPlayers()
        playerCollectionView.reloadData()
        searchTipsView.isHidden = !viewModel.hasNoResults
    }
    
    private func setupFilterMode(with sender: UIButton)  {
        toggleStatus(sender)
        viewModel.toggleFilter(byTag: sender.tag)
        updateUI()
        if !sender.isSelected {
            searchTipsView.isHidden = !viewModel.isFiltersInactive
        }
    }
    
    private func toggleStatus(_ sender: UIButton) {
        sender.isSelected.toggle()
        sender.tintColor = sender.isSelected ? .systemGreen : .white
    }
    
    // MARK: Actions
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

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
        
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text,
              !searchText.isEmpty else {
            noResultsLabel.isHidden = true
            viewModel.returnOriginalPlayers()
            playerCollectionView.reloadData()
            return
        }
        searchTipsView.isHidden = true
        noResultsLabel.isHidden = !searchText.isEmpty
        activityIndicator.startAnimating()
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(
            withTimeInterval: 0.5,
            repeats: false,
            block: { [weak self] _ in
                guard let self else { return }
                viewModel.findPlayers(byText: searchText) {
                    self.playerCollectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.noResultsLabel.isHidden = !self.viewModel.hasNoResults
                }
            })
    }
}

// MARK: - UISearchControllerDelegate
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
            playerCollectionView.topAnchor.constraint(
                equalTo: view.topAnchor),
            playerCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            playerCollectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
            playerCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor)
        ])
    }
}
