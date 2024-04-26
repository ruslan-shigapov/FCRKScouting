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
    private lazy var playersCollectionView: UICollectionView = {
        let collectionView = VerticalCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        let elementKind = UICollectionView.elementKindSectionHeader
        collectionView.register(
            DateCollectionReusableView.self,
            forSupplementaryViewOfKind: elementKind,
            withReuseIdentifier: DateCollectionReusableView.identifier)
        collectionView.register(
            PlayerCollectionViewCell.self,
            forCellWithReuseIdentifier: PlayerCollectionViewCell.identifier)
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
        view.addSubview(playersCollectionView)
        setupNavigationBarItems()
        setConstraints()
    }
    
    // MARK: Private Methods 
    private func setupNavigationBarItems() {
        let addPlayerButton = RightNavigationBarButton(
            image: Constants.Images.ButtonImages.addPlayer)
        addPlayerButton.addTarget(
            self,
            action: #selector(addPlayerButtonTapped),
            for: .touchUpInside)
        if viewModel.isAddingAllowed {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                customView: addPlayerButton)
        }
        let periodSegmentedControl = GraySegmentedControl(
            items: Constants.Text.SegmentedControlItems.periodSegments)
        let leftBarButtonItem = UIBarButtonItem(
            customView: periodSegmentedControl)
        navigationItem.leftBarButtonItem = leftBarButtonItem
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
        playerAddingVC.modalPresentationStyle = .fullScreen
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
        1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PlayerCollectionViewCell.identifier,
            for: indexPath) as? PlayerCollectionViewCell
        cell?.configureWith(
            fullName: "Даниил Кирягин",
            age: "18 лет",
            position: "\"ЦЗ\"",
            photo: nil)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String, 
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: DateCollectionReusableView.identifier,
            for: indexPath) as? DateCollectionReusableView
        headerView?.configureWith(date: "16.04.2024")
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
        NSLayoutConstraint.activate([
            playersCollectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            playersCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            playersCollectionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            playersCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor)
        ])
    }
}
