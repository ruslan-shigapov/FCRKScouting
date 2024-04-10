//
//  UpdatesViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 26.03.2024.
//

import UIKit

final class UpdatesViewController: UIViewController {
    
    private let emptyScreenLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Здесь будет отображаться список по датам - информация по последним добавленным игрокам"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(emptyScreenLabel)
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

// MARK: - Layout
private extension UpdatesViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
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
