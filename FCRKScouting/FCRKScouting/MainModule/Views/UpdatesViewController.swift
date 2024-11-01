//
//  UpdatesViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 26.03.2024.
//

import UIKit

final class UpdatesViewController: UIViewController {
    
    // MARK: Private Properties
    private let viewModel: UpdatesViewModel
    
    private lazy var collectionViewDataSource = PlayerCollectionViewDataSource(
        viewModel: viewModel)
    private lazy var collectionViewDelegate = PlayerCollectionViewDelegate(
        viewModel: viewModel,
        navigationController: navigationController)
    
    // MARK: Views
    private lazy var refreshButton: NavigationBarButton = {
        $0.addTarget(
            self,
            action: #selector(refreshButtonTapped),
            for: .touchUpInside)
        return $0
    }(NavigationBarButton(image: Constants.Images.ButtonImages.refresh))
    
    private lazy var addPlayerButton: NavigationBarButton = {
        $0.addTarget(
            self,
            action: #selector(addPlayerButtonTapped),
            for: .touchUpInside)
        return $0
    }(NavigationBarButton(image: Constants.Images.ButtonImages.add))
    
    private lazy var intervalSegmentedControl: GraySegmentedControl = {
        $0.addTarget(
            self,
            action: #selector(intervalSegmentedControlValueChanged),
            for: .valueChanged)
        return $0
    }(GraySegmentedControl(
        items: Constants.Texts.SegmentedControlItems.periodSegments))
    
    private lazy var segmentedControlBackgroundView: UIView = {
        $0.backgroundColor = .rubin
        $0.addSubview(intervalSegmentedControl)
        $0.prepareForAutoLayout()
        return $0
    }(UIView())
    
    private lazy var playerCollectionView: PlayerCollectionView = {
        $0.delegate = collectionViewDelegate
        $0.dataSource = collectionViewDataSource
        return $0
    }(PlayerCollectionView())

    private let noResultsLabel = NoResultsLabel(
        text: Constants.Texts.noIntervalResults)
    
    private let activityIndicator = LargeActivityIndicatorView()
    
    // MARK: Initialize
    init(viewModel: UpdatesViewModel) {
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
        addNavigationBarButtons()
        setupNoResultsLabelDisplaying()
        view.setupGradientLayer()
        view.addSubviews(
            segmentedControlBackgroundView,
            playerCollectionView,
            noResultsLabel,
            activityIndicator)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func addNavigationBarButtons() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: refreshButton)
        ]
        if viewModel.isEditingAllowed {
            navigationItem.rightBarButtonItems?.append(
                UIBarButtonItem(customView: addPlayerButton))
        }
    }
    
    private func setupNoResultsLabelDisplaying() {
        noResultsLabel.isHidden = !viewModel.hasNoResults
    }
    
    private func handleEvents() {
        viewModel.onPlayersChanged = { [weak self] in
            guard let self else { return }
            startUpdatingUI()
            playerCollectionView.setContentOffset(.zero, animated: true)
            viewModel.fetchPlayers {
                self.resetUI()
            }
        }
        viewModel.onPlayersPossiblyChanged = { [weak self] in
            guard let self else { return }
            startUpdatingUI()
            viewModel.fetchPlayers {
                self.resetUI()
            }
        }
    }
        
    private func startUpdatingUI() {
        noResultsLabel.isHidden = true
        activityIndicator.startAnimating()
    }
    
    private func resetUI() {
        playerCollectionView.reloadData()
        activityIndicator.stopAnimating()
        setupNoResultsLabelDisplaying()
    }
    
    // MARK: Actions
    @objc private func refreshButtonTapped() {
        startUpdatingUI()
        viewModel.syncWithDatabase() { [weak self] in
            guard let self else { return }
            playerCollectionView.setContentOffset(.zero, animated: true)
        }
        viewModel.fetchPlayers { [weak self] in
            guard let self else { return }
            resetUI()
        }
    }
    
    @objc private func addPlayerButtonTapped() {
        let editorVC = ScreenFactory.getEditorViewController(
            withDelegate: viewModel as EditorViewControllerDelegate)
        present(editorVC, animated: true)
    }
    
    @objc private func intervalSegmentedControlValueChanged(
        _ sender: UISegmentedControl
    ) {
        viewModel.currentInterval = sender.selectedSegmentIndex
        playerCollectionView.setContentOffset(.zero, animated: true)
        resetUI()
    }
}

// MARK: - Layout
private extension UpdatesViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            segmentedControlBackgroundView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControlBackgroundView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            segmentedControlBackgroundView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            
            intervalSegmentedControl.topAnchor.constraint(
                equalTo: segmentedControlBackgroundView.topAnchor,
                constant: 5),
            intervalSegmentedControl.leadingAnchor.constraint(
                equalTo: segmentedControlBackgroundView.leadingAnchor,
                constant: 16),
            intervalSegmentedControl.bottomAnchor.constraint(
                equalTo: segmentedControlBackgroundView.bottomAnchor,
                constant: -16),
            intervalSegmentedControl.trailingAnchor.constraint(
                equalTo: segmentedControlBackgroundView.trailingAnchor,
                constant: -16),
            
            playerCollectionView.topAnchor.constraint(
                equalTo: segmentedControlBackgroundView.bottomAnchor),
            playerCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            playerCollectionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            playerCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor)
        ])
    }
}
