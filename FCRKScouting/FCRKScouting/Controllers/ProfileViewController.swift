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
    private let logoImageView = UIImageView(image: Constants.Images.logo)

    private lazy var fullNameLabel = CustomWhiteLabel(
        font: Constants.Fonts.header,
        numberOfLines: 2,
        text: viewModel.fullName)
    
    private lazy var topBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .accent
        view.setCustomCornerRadius()
        view.addSubviews(logoImageView, fullNameLabel)
        view.prepareForAutoLayout()
        return view
    }()
    
    private lazy var viewingPlanNavigationButton: UIButton = {
        let button = CustomNavigationButton(
            title: Constants.Text.viewingPlan)
        return button
    }()
    
    private lazy var allReportsNavigationButton: UIButton = {
        let button = CustomNavigationButton(
            title: Constants.Text.allReports)
        return button
    }()
    
    private lazy var userInfoView = UserInfoView(
        post: viewModel.post,
        access: viewModel.access)
    
    private lazy var logoutButton: UIButton = {
        let button = PrimaryButton(title: Constants.Text.ButtonTitles.exit)
        button.addTarget(
            self,
            action: #selector(logOutButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .accent
        view.setCustomCornerRadius()
        view.addSubviews(userInfoView, logoutButton)
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
    }
    
    // MARK: Private Methods
    private func setupUI() {
        setupNavigationBarButton()
        fullNameLabel.textAlignment = .center
        view.setCustomGradientLayer()
        view.addSubviews(
            topBackgroundView,
            viewingPlanNavigationButton,
            allReportsNavigationButton,
            bottomBackgroundView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setupNavigationBarButton() {
        let filtersButton = CustomNavigationBarButton(
            image: Constants.Images.ButtonImages.edit)
        filtersButton.addTarget(
            self,
            action: #selector(editButtonTapped),
            for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: filtersButton)
        navigationItem.rightBarButtonItem = barButtonItem
    }

    @objc private func editButtonTapped() {
        
    }
    
    @objc private func logOutButtonTapped() {
        let exitAlert = AlertFactory.getExitAlert { [weak self] in
            self?.viewModel.logOut()
        }
        present(exitAlert, animated: true)
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
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 90),
            
            fullNameLabel.leadingAnchor.constraint(
                equalTo: logoImageView.trailingAnchor,
                constant: 24),
            fullNameLabel.trailingAnchor.constraint(
                equalTo: topBackgroundView.trailingAnchor,
                constant: -24),
            fullNameLabel.centerYAnchor.constraint(
                equalTo: topBackgroundView.centerYAnchor),
            
            viewingPlanNavigationButton.topAnchor.constraint(
                equalTo: topBackgroundView.bottomAnchor,
                constant: 8),
            viewingPlanNavigationButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 8),
            viewingPlanNavigationButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -8),
            viewingPlanNavigationButton.heightAnchor.constraint(
                equalToConstant: 74),
            
            allReportsNavigationButton.topAnchor.constraint(
                equalTo: viewingPlanNavigationButton.bottomAnchor,
                constant: 8),
            allReportsNavigationButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 8),
            allReportsNavigationButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -8),
            allReportsNavigationButton.heightAnchor.constraint(
                equalToConstant: 74),
            
            bottomBackgroundView.topAnchor.constraint(
                equalTo: allReportsNavigationButton.bottomAnchor,
                constant: 8),
            bottomBackgroundView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 8),
            bottomBackgroundView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -8),
            
            userInfoView.topAnchor.constraint(
                equalTo: bottomBackgroundView.topAnchor,
                constant: 24),
            userInfoView.leadingAnchor.constraint(
                equalTo: bottomBackgroundView.leadingAnchor,
                constant: 24),
            userInfoView.trailingAnchor.constraint(
                equalTo: bottomBackgroundView.trailingAnchor,
                constant: -24),
            
            logoutButton.topAnchor.constraint(
                equalTo: userInfoView.bottomAnchor,
                constant: 24),
            logoutButton.bottomAnchor.constraint(
                equalTo: bottomBackgroundView.bottomAnchor,
                constant: -24),
            logoutButton.centerXAnchor.constraint(
                equalTo: bottomBackgroundView.centerXAnchor)    
        ])
    }
}
