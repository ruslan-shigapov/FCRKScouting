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
    private lazy var userTitleView = TitleViewWithImage(
        title: viewModel.fullName,
        imageView: UIImageView(image: Constants.Images.logo)
    )
    
    private lazy var viewingPlanNavigationButton: UIButton = {
        let button = CustomNavigationButton(title: "План просмотра")
        return button
    }()
    
    private let accessLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.access
    )
    
    private lazy var accessValueLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.access
        label.font = Constants.Fonts.text
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = PrimaryButton(
            title: Constants.Text.ButtonTitles.exit
        )
        button.addTarget(
            self,
            action: #selector(logOutButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .accent
        view.setCustomCornerRadius()
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
    }
    
    // MARK: Private Methods
    private func setupUI() {
        setupNavigationBarButton()
        view.backgroundColor = .white
        view.addSubviews(
            userTitleView,
            viewingPlanNavigationButton,
            backgroundView
        )
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setupNavigationBarButton() {
        let editButton = CustomNavigationBarButton(
            image: Constants.Images.ButtonImages.edit
        )
        editButton.addTarget(
            self,
            action: #selector(editButtonTapped),
            for: .touchUpInside
        )
        let barButtonItem = UIBarButtonItem(customView: editButton)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func logOutButtonTapped() {
        let exitAlert = AlertFactory.getExitAlert { [weak self] in
            self?.viewModel.logOut()
        }
        present(exitAlert, animated: true)
    }
    
    @objc private func editButtonTapped() {
        let editAlert = AlertFactory.getEditAlert(
            withTitle: Constants.Text.ActionSheets.edit
        )
        present(editAlert, animated: true)
    }
}

// MARK: - Layout
private extension ProfileViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            userTitleView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 8
            ),
            userTitleView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 8
            ),
            userTitleView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -8
            ),
            
            viewingPlanNavigationButton.topAnchor.constraint(
                equalTo: userTitleView.bottomAnchor,
                constant: 8
            ),
            viewingPlanNavigationButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 8
            ),
            viewingPlanNavigationButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -8
            ),
            viewingPlanNavigationButton.heightAnchor.constraint(
                equalToConstant: 74
            ),
            
            backgroundView.topAnchor.constraint(
                equalTo: viewingPlanNavigationButton.bottomAnchor,
                constant: 8
            ),
            backgroundView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 8
            ),
            backgroundView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -8
            ),
            
            accessLabel.topAnchor.constraint(
                equalTo: backgroundView.topAnchor,
                constant: 24
            ),
            accessLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24
            ),
            
            accessValueLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24
            ),
            accessValueLabel.topAnchor.constraint(
                equalTo: accessLabel.bottomAnchor,
                constant: 5
            ),
            
            logoutButton.topAnchor.constraint(
                equalTo: accessLabel.bottomAnchor,
                constant: 48
            ),
            logoutButton.bottomAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: -24
            ),
            logoutButton.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor
            )    
        ])
    }
}
