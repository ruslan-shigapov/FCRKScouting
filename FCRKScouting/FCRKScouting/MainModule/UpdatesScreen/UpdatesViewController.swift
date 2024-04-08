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
        let addPlayerButton = NavigationBarButton(
            image: Constants.Images.ButtonImages.addPlayer)
        addPlayerButton.addTarget(
            self,
            action: #selector(addPlayerButtonTapped),
            for: .touchUpInside)
        let rightBarButtonItem = UIBarButtonItem(customView: addPlayerButton)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let timeSegmentedControl = FilterSegmentedControl(
            items: Constants.Text.SegmentedControlItems.timeSegments)
        let leftBarButtonItem = UIBarButtonItem(
            customView: timeSegmentedControl)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc private func addPlayerButtonTapped() {
        let addPlayerVC = ScreenFactory.getPlayerAddingViewController()
        present(addPlayerVC, animated: true)
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
