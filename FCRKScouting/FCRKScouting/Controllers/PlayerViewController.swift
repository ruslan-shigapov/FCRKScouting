//
//  PlayerViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 20.06.2024.
//

import UIKit

final class PlayerViewController: UIViewController {
    
    // MARK: Views
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.deepGreen
        view.setCommonCornerRadius()
        view.addSubviews(
            showStatisticsDetailsButton,
            showTestingDetailsButton)
        view.prepareForAutoLayout()
        return view
    }()
    
    private lazy var showStatisticsDetailsButton: UIButton = {
        let button = PrimaryButton(
            title: "Статистика",
            color: .accent)
        button.addTarget(
            self,
            action: #selector(showStatisticsDetailsButtonTapped),
            for: .touchUpInside)
        return button
    }()
    private lazy var showTestingDetailsButton: UIButton = {
        let button = PrimaryButton(
            title: Constants.Text.testingDetails,
            color: .accent)
        button.addTarget(
            self,
            action: #selector(showTestingDetailsButtonTapped),
            for: .touchUpInside)
        return button
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        setupNavigationBar()
        view.backgroundColor = .accent
        view.addSubview(backgroundView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        let backButton = UIBarButtonItem(
            title: "Назад",
            style: .plain,
            target: self,
            action: #selector(backButtonTapped))
        backButton.setTitleTextAttributes(
            [.font : Constants.Fonts.normal as Any],
            for: .normal)
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func showStatisticsDetailsButtonTapped() {
        let statisticsDetailsVC = ScreenFactory.getStatisticsDetailsVC()
        present(statisticsDetailsVC, animated: true)
    }
    
    @objc private func showTestingDetailsButtonTapped() {
        let testingDetailsVC = ScreenFactory.getTestingDetailsVC()
        present(testingDetailsVC, animated: true)
    }
}

// MARK: - Layout
private extension PlayerViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16),
            backgroundView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            backgroundView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -24),
            backgroundView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
            showStatisticsDetailsButton.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            showStatisticsDetailsButton.bottomAnchor.constraint(
                equalTo: showTestingDetailsButton.topAnchor,
                constant: -16),
            showStatisticsDetailsButton.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -24),
            
            showTestingDetailsButton.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            showTestingDetailsButton.bottomAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: -24),
            showTestingDetailsButton.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -24),
        ])
    }
}
