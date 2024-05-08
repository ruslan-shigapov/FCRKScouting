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
    private let periodSegmentedControl = GraySegmentedControl(
        items: Constants.Text.SegmentedControlItems.periodSegments
    )
    
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
        view.backgroundColor = .accent
        view.addSubview(periodSegmentedControl)
        view.addSubview(playersCollectionView)
        setupNavigationBarItems()
        setConstraints()
    }
    
    // MARK: Private Methods 
    private func setupNavigationBarItems() {
        let refreshButton = CustomNavigationBarButton(
            image: UIImage(named: "repeat")
        )
        let addPlayerButton = CustomNavigationBarButton(
            image: Constants.Images.ButtonImages.addPlayer
        )
        addPlayerButton.addTarget(
            self,
            action: #selector(addPlayerButtonTapped),
            for: .touchUpInside
        )
        if viewModel.isEditingAllowed {
            // TODO: не отображается вторая кнопка
//            navigationItem.rightBarButtonItem = UIBarButtonItem(
//                customView: addPlayerButton
//            )
        }
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: addPlayerButton),
            UIBarButtonItem(customView: refreshButton)
        ]
    }
    
    @objc private func addPlayerButtonTapped() {
        let allowAlert = AlertFactory.getAllowAlert(
            withTitle: Constants.Text.Alerts.playerAdding
        ) { [weak self] in
            self?.showPlayerAddingScreen()
        }
        present(allowAlert, animated: true)
    }
    
    private func showPlayerAddingScreen() {
        let playerAddingVC = ScreenFactory.getPlayerAddingViewController()
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
            for: indexPath) as? PlayerCell
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
            for: indexPath) as? DateHeaderView
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
        CGSize(width: collectionView.bounds.width - 16, height: 100)
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
        view.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            periodSegmentedControl.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 4
            ),
            periodSegmentedControl.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, 
                constant: 8
            ),
            periodSegmentedControl.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, 
                constant: -8
            ),
            
            playersCollectionView.topAnchor.constraint(
                equalTo: periodSegmentedControl.bottomAnchor,
                constant: 8
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
