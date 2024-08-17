//
//  ProfileViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 12.03.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: Private Properties
    private var viewModel: ProfileViewModelProtocol
        
    // MARK: Views
    private lazy var editButton: NavigationBarButton = {
        let button = NavigationBarButton(
            image: Constants.Images.ButtonImages.edit)
        button.addTarget(
            self,
            action: #selector(editButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private let logoImageView = UIImageView(image: Constants.Images.logo)

    private lazy var fullNameLabel: CustomLabel = {
        let label = CustomLabel(
            font: Constants.Fonts.header,
            text: viewModel.profileFullName,
            numberOfLines: 2)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var topBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .rubin
        view.setupCornerRadius()
        view.addSubviews(logoImageView, fullNameLabel)
        view.prepareForAutoLayout()
        return view
    }()
    
    private let accessLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Texts.Titles.access)
    
    private lazy var accessValueLabel = DefaultTextLabel(text: viewModel.access)
    
    private lazy var logoutButton: PrimaryButton = {
        let button = PrimaryButton(title: Constants.Texts.ButtonTitles.exit)
        button.addTarget(
            self,
            action: #selector(logOutButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .rubin
        view.setupCornerRadius()
        view.addSubviews(accessLabel, accessValueLabel, logoutButton)
        view.prepareForAutoLayout()
        return view
    }()
    
    // MARK: Initialize
    init(viewModel: ProfileViewModelProtocol) {
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
        view.setupGradientLayer()
        view.addSubviews(
            topBackgroundView,
            bottomBackgroundView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func handleEvents() {
        viewModel.userWasUpdated = { [weak self] in
            guard let self else { return }
            fullNameLabel.text = viewModel.profileFullName
        }
    }
    
    private func addNavigationBarButtons() {
        let barButtonItem = UIBarButtonItem(customView: editButton)
        navigationItem.rightBarButtonItem = barButtonItem
    }

    @objc private func editButtonTapped() {
        let formVC = ScreenFactory.getFormController(
            withDelegate: viewModel as FormViewControllerDelegate)
        if let sheet = formVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        present(formVC, animated: true)
    }
    
    @objc private func logOutButtonTapped() {
        let alertController = AlertFactory.getConfirmationAlert(
            withTitle: Constants.Texts.Alerts.exit.title,
            andMessage: Constants.Texts.Alerts.exit.message
        ) { [weak self] in
            guard let self else { return }
            viewModel.logOut()
        }
        present(alertController, animated: true)
    }
}

// MARK: - Layout
private extension ProfileViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            topBackgroundView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 8),
            topBackgroundView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 8),
            topBackgroundView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -8),
            
            logoImageView.topAnchor.constraint(
                equalTo: topBackgroundView.topAnchor,
                constant: 24),
            logoImageView.leadingAnchor.constraint(
                equalTo: topBackgroundView.leadingAnchor,
                constant: 24),
            logoImageView.bottomAnchor.constraint(
                equalTo: topBackgroundView.bottomAnchor,
                constant: -24),
            logoImageView.heightAnchor.constraint(equalToConstant: 110),
            logoImageView.widthAnchor.constraint(equalToConstant: 90),
            
            fullNameLabel.leadingAnchor.constraint(
                equalTo: logoImageView.trailingAnchor,
                constant: 24),
            fullNameLabel.trailingAnchor.constraint(
                equalTo: topBackgroundView.trailingAnchor,
                constant: -24),
            fullNameLabel.centerYAnchor.constraint(
                equalTo: topBackgroundView.centerYAnchor),
            
            bottomBackgroundView.topAnchor.constraint(
                equalTo: topBackgroundView.bottomAnchor,
                constant: 8),
            bottomBackgroundView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 8),
            bottomBackgroundView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -8),
            
            accessLabel.topAnchor.constraint(
                equalTo: bottomBackgroundView.topAnchor,
                constant: 24),
            accessLabel.leadingAnchor.constraint(
                equalTo: bottomBackgroundView.leadingAnchor,
                constant: 24),
            
            accessValueLabel.topAnchor.constraint(
                equalTo: accessLabel.bottomAnchor,
                constant: 4),
            accessValueLabel.leadingAnchor.constraint(
                equalTo: bottomBackgroundView.leadingAnchor,
                constant: 24),
            
            logoutButton.topAnchor.constraint(
                equalTo: accessValueLabel.bottomAnchor,
                constant: 24),
            logoutButton.leadingAnchor.constraint(
                equalTo: bottomBackgroundView.leadingAnchor,
                constant: 24),
            logoutButton.bottomAnchor.constraint(
                equalTo: bottomBackgroundView.bottomAnchor,
                constant: -24),
            logoutButton.trailingAnchor.constraint(
                equalTo: bottomBackgroundView.trailingAnchor,
                constant: -24),
            logoutButton.centerXAnchor.constraint(
                equalTo: bottomBackgroundView.centerXAnchor)    
        ])
    }
}
