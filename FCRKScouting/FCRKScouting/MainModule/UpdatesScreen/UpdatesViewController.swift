//
//  UpdatesViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 26.03.2024.
//

import UIKit

final class UpdatesViewController: UIViewController {
    
    private lazy var playersCollectionView: UICollectionView = {
        let collectionView = VerticalCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            PlayerCollectionViewCell.self,
            forCellWithReuseIdentifier: PlayerCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(playersCollectionView)
        setupNavigationBarItems()
        setConstraints()
    }
    
    private func setupNavigationBarItems() {
        let addPlayerButton = NavigationRightBarButton(
            image: Constants.Images.ButtonImages.addPlayer)
        addPlayerButton.addTarget(
            self,
            action: #selector(addPlayerButtonTapped),
            for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            customView: addPlayerButton)
        
        let timeSegmentedControl = GraySegmentedControl(
            items: Constants.Text.SegmentedControlItems.timeSegments)
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            customView: timeSegmentedControl)
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
            for: indexPath)
        return cell
    }
}

// MARK: - Collection View Delegate Flow Layout
extension UpdatesViewController: UICollectionViewDelegateFlowLayout {
    
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
        UIEdgeInsets(top: 8, left: 0, bottom: 12, right: 0)
    }
}

// MARK: - Layout
extension UpdatesViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            playersCollectionView.topAnchor.constraint(
                equalTo: view.topAnchor),
            playersCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            playersCollectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
            playersCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor)
        ])
    }
}
