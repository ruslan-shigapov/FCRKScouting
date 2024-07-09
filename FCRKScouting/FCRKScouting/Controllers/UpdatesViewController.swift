//
//  UpdatesViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 26.03.2024.
//

import UIKit

final class UpdatesViewController: UIViewController {
    
    // MARK: Private Properties
    private var viewModel: UpdatesViewModelProtocol
    
    private lazy var collectionViewDelegate = UpdatesCollectionDelegate(
        navigationController: navigationController,
        viewModel: viewModel)
    private lazy var collectionViewDataSource = UpdatesCollectionDataSource(
        viewModel: viewModel)
    
    // MARK: Views
    private lazy var refreshButton: NavigationBarButton = {
        let button = NavigationBarButton(
            image: Constants.Images.ButtonImages.refresh)
        button.addTarget(
            self,
            action: #selector(refreshButtonTapped),
            for: .touchUpInside)
        return button
    }()
    private lazy var addPlayerButton: NavigationBarButton = {
        let button = NavigationBarButton(
            image: Constants.Images.ButtonImages.add)
        button.addTarget(
            self,
            action: #selector(addPlayerButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private lazy var intervalSegmentedControl: GraySegmentedControl = {
        let segmentedControl = GraySegmentedControl(
            items: Constants.Text.SegmentedControlItems.periodSegments)
        segmentedControl.addTarget(
            self,
            action: #selector(intervalSegmentedControlValueChanged),
            for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var segmentedControlBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .accent
        view.addSubview(intervalSegmentedControl)
        view.prepareForAutoLayout()
        return view
    }()
    
    private lazy var playerCollectionView: PlayerCollectionView = {
        let collectionView = PlayerCollectionView()
        collectionView.delegate = collectionViewDelegate
        collectionView.dataSource = collectionViewDataSource
        let elementKind = UICollectionView.elementKindSectionHeader
        collectionView.register(
            DateHeaderView.self,
            forSupplementaryViewOfKind: elementKind,
            withReuseIdentifier: String(describing: DateHeaderView.self))
        collectionView.register(
            PlayerCell.self,
            forCellWithReuseIdentifier: String(describing: PlayerCell.self))
        return collectionView
    }()
    
    private let noResultsLabel: DefaultTextLabel = {
        let label = DefaultTextLabel(
            text: Constants.Text.noIntervalResults,
            numberOfLines: 2)
        label.textColor = .white
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.hidesWhenStopped = true
        indicatorView.color = .naturalGold
        return indicatorView
    }()
    
    // MARK: Initialize
    init(viewModel: UpdatesViewModelProtocol) {
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
        handlePlayerAdding()
        handleReturnBack()
    }
    
    // MARK: Private Methods 
    private func setupUI() {
        addNavigationBarButtons()
        setupNoResultsLabelDisplaying()
        view.setupGradientLayer()
        view.addSubviews(
            segmentedControlBackgroundView,
            noResultsLabel,
            playerCollectionView,
            activityIndicator)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func handlePlayerAdding() {
        viewModel.playersWereChanged = { [weak self] in
            guard let self else { return }
            refreshButtonTapped()
        }
    }
    
    private func handleReturnBack() {
        viewModel.backButtonWasTapped = { [weak self] in
            guard let self else { return }
            refreshButtonTapped()
        }
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
    
    private func updateCollectionView() {
        playerCollectionView.setContentOffset(.zero, animated: true)
        setupNoResultsLabelDisplaying()
        playerCollectionView.reloadData()
    }
    
    @objc private func refreshButtonTapped() {
        noResultsLabel.isHidden = true
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            guard let self else { return }
            viewModel.refreshPlayersList {
                self.updateCollectionView()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    @objc private func addPlayerButtonTapped() {
        let playerAddingVC = ScreenFactory.getEditorViewController(
            withDelegate: viewModel as EditorViewControllerDelegate, 
            andPlayer: nil)
        present(playerAddingVC, animated: true)
    }
    
    @objc private func intervalSegmentedControlValueChanged(
        _ sender: UISegmentedControl
    ) {
        viewModel.currentInterval = sender.selectedSegmentIndex
        updateCollectionView()
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
                constant: 4),
            intervalSegmentedControl.leadingAnchor.constraint(
                equalTo: segmentedControlBackgroundView.leadingAnchor,
                constant: 16),
            intervalSegmentedControl.bottomAnchor.constraint(
                equalTo: segmentedControlBackgroundView.bottomAnchor,
                constant: -16),
            intervalSegmentedControl.trailingAnchor.constraint(
                equalTo: segmentedControlBackgroundView.trailingAnchor,
                constant: -16),
            
            noResultsLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
            noResultsLabel.widthAnchor.constraint(equalToConstant: 170),
            
            playerCollectionView.topAnchor.constraint(
                equalTo: segmentedControlBackgroundView.bottomAnchor),
            playerCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            playerCollectionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            playerCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(
                equalTo: view.centerYAnchor)
        ])
    }
}
