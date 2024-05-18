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
    
    // MARK: Views
    private lazy var addPlayerButton: UIButton = {
        let button = CustomNavigationBarButton(
            image: Constants.Images.ButtonImages.addPlayer
        )
        button.addTarget(
            self,
            action: #selector(addPlayerButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = CustomNavigationBarButton(
            image: Constants.Images.ButtonImages.refresh
        )
        button.addTarget(
            self,
            action: #selector(refreshButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var intervalSegmentedControl: UISegmentedControl = {
        let segmentedControl = GraySegmentedControl(
            items: Constants.Text.SegmentedControlItems.periodSegments
        )
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(
            self,
            action: #selector(intervalSegmentedControlValueChanged),
            for: .valueChanged
        )
        return segmentedControl
    }()
    
    private lazy var segmentedControlBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .accent
        view.addSubview(intervalSegmentedControl)
        return view
    }()
    
    private lazy var playersCollectionView: UICollectionView = {
        let collectionView = VerticalCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
        let elementKind = UICollectionView.elementKindSectionHeader
        collectionView.register(
            DateHeaderView.self,
            forSupplementaryViewOfKind: elementKind,
            withReuseIdentifier: String(describing: DateHeaderView.self)
        )
        collectionView.register(
            PlayerCell.self,
            forCellWithReuseIdentifier: String(describing: PlayerCell.self)
        )
        return collectionView
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
        handlePlayerAddition()
    }
    
    // MARK: Private Methods 
    private func setupUI() {
        addNavigationBarButtons()
        view.setCustomGradientLayer()
        view.addSubviews(segmentedControlBackgroundView, playersCollectionView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func addNavigationBarButtons() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: refreshButton)
        ]
        if viewModel.isEditingAllowed {
            navigationItem.rightBarButtonItems?.append(
                UIBarButtonItem(customView: addPlayerButton)
            )
        }
    }
    
    private func handlePlayerAddition() {
        viewModel.playerWasAdded = { [weak self] in
            self?.viewModel.refreshPlayers {
                self?.updateCollectionView()
            }
        }
    }
    
    @objc private func refreshButtonTapped() {
        viewModel.refreshPlayers {
            updateCollectionView()
        }
    }
    
    @objc private func addPlayerButtonTapped() {
        showPlayerAddingScreen()
    }
    
    @objc private func intervalSegmentedControlValueChanged(
        _ sender: UISegmentedControl
    ) {
        viewModel.currentInterval = sender.selectedSegmentIndex
        updateCollectionView()
    }
    
    private func updateCollectionView() {
        playersCollectionView.setContentOffset(.zero, animated: true)
        playersCollectionView.reloadData()
    }
    
    private func showPlayerAddingScreen() {
        let playerAddingVC = ScreenFactory.getPlayerAddingViewController(
            withDelegate: viewModel as PlayerAddingViewControllerDelegate
        )
        present(playerAddingVC, animated: true)
    }
}

// MARK: - Collection View Data Source
extension UpdatesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.getNumberOfSections()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.getNumberOfItemsIn(section)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: PlayerCell.self),
            for: indexPath
        ) as? PlayerCell
        cell?.viewModel = viewModel.getPlayerCellViewModel(at: indexPath)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String, 
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: String(describing: DateHeaderView.self),
            for: indexPath
        ) as? DateHeaderView
        let sectionDate = viewModel.sortedDates[indexPath.section]
        headerView?.configureWith(
            date: viewModel.format(sectionDate)
        )
        return headerView ?? UICollectionReusableView()
    }
}

// MARK: - Collection View Delegate Flow Layout
extension UpdatesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 30)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.bounds.width - 16, height: 90)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        if section == (collectionView.numberOfSections - 1) {
            return UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        } else {
            return UIEdgeInsets.zero
        }
    }
}

// MARK: - Layout
extension UpdatesViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            segmentedControlBackgroundView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            segmentedControlBackgroundView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            segmentedControlBackgroundView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            
            intervalSegmentedControl.topAnchor.constraint(
                equalTo: segmentedControlBackgroundView.topAnchor,
                constant: 4
            ),
            intervalSegmentedControl.leadingAnchor.constraint(
                equalTo: segmentedControlBackgroundView.leadingAnchor,
                constant: 8
            ),
            intervalSegmentedControl.bottomAnchor.constraint(
                equalTo: segmentedControlBackgroundView.bottomAnchor,
                constant: -8
            ),
            intervalSegmentedControl.trailingAnchor.constraint(
                equalTo: segmentedControlBackgroundView.trailingAnchor,
                constant: -8
            ),
            
            playersCollectionView.topAnchor.constraint(
                equalTo: segmentedControlBackgroundView.bottomAnchor
            ),
            playersCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            playersCollectionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
            playersCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            )
        ])
    }
}
