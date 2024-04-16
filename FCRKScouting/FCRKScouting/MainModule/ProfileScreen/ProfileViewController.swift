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
    private lazy var userTitleView = PersonTitleView(title: viewModel.fullName)
    
    private let editButton = EditButton()
    
    private let accessLabel = WhiteLabel()
    
    private lazy var accessValueLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.access
        label.font = Constants.Fonts.text
        label.textColor = .lightGray
        return label
    }()
    
    private let logoutButton = PrimaryButton(
        title: Constants.Text.ButtonTitles.exit)
    
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .accent
        view.addSubview(accessLabel)
        view.addSubview(accessValueLabel)
        view.addSubview(logoutButton)
        view.layer.cornerRadius = 12
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
        view.backgroundColor = .white
        accessLabel.text = Constants.Text.access
        addSubviews()
        setupButtons()
        setConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(userTitleView)
        view.addSubview(editButton)
        view.addSubview(backgroundView)
    }
    
    private func setupButtons() {
        logoutButton.addTarget(
            self,
            action: #selector(logOutButtonTapped),
            for: .touchUpInside)
        editButton.addTarget(
            self,
            action: #selector(editButtonTapped),
            for: .touchUpInside)
    }
    
    @objc private func logOutButtonTapped() {
        let exitAlert = AlertFactory.getExitAlert { [weak self] in
            self?.viewModel.logOut()
        }
        present(exitAlert, animated: true)
    }
    
    @objc private func editButtonTapped() {
        let editAlert = AlertFactory.getEditAlert(
            withTitle: Constants.Text.ActionSheets.edit)
        present(editAlert, animated: true)
    }
}

// MARK: - Layout
private extension ProfileViewController {
    
    func setConstraints() {
        view.subviews.forEach(prepareForAutoLayout)
        backgroundView.subviews.forEach(prepareForAutoLayout)
        
        NSLayoutConstraint.activate([
            userTitleView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 8),
            userTitleView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 8),
            userTitleView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -8),
            
            editButton.topAnchor.constraint(
                equalTo: userTitleView.topAnchor,
                constant: 12),
            editButton.trailingAnchor.constraint(
                equalTo: userTitleView.trailingAnchor,
                constant: -12),
            
            backgroundView.topAnchor.constraint(
                equalTo: userTitleView.bottomAnchor,
                constant: 8),
            backgroundView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 8),
            backgroundView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -8),
            
            accessLabel.topAnchor.constraint(
                equalTo: backgroundView.topAnchor,
                constant: 24),
            accessLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            
            accessValueLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            accessValueLabel.topAnchor.constraint(
                equalTo: accessLabel.bottomAnchor,
                constant: 5),
            
            logoutButton.topAnchor.constraint(
                equalTo: accessLabel.bottomAnchor,
                constant: 48),
            logoutButton.bottomAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: -24),
            logoutButton.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor)    
        ])
    }
}
