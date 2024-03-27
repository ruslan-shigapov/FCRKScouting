//
//  ProfileViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 12.03.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
        
    // MARK: Views
    private let userTitleView = PersonTitleView()
    
    private let accessLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.access
        label.font = Constants.Fonts.normal
        label.textColor = .white
        return label
    }()
    
    private lazy var accessValueLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.access
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    private let logoutButton = PrimaryButton(
        title: Constants.Text.ButtonTitle.exit)
    
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .accent
        view.addSubview(accessLabel)
        view.addSubview(accessValueLabel)
        view.addSubview(logoutButton)
        view.layer.cornerRadius = 12
        return view
    }()
    
    // MARK: Dependencies
    private var viewModel: ProfileViewModelProtocol {
        didSet {
            
        }
    }
    
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
        view.backgroundColor = .systemBackground
        userTitleView.configure(withFullName: viewModel.fullName)
        logoutButton.addTarget(
            self,
            action: #selector(logOutButtonTapped),
            for: .touchUpInside)
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(userTitleView)
        view.addSubview(backgroundView)
    }
    
    @objc private func logOutButtonTapped() {
        StorageManager.shared.deleteUser()
        dismiss(animated: true)
    }
}

// MARK: - Layout
private extension ProfileViewController {
    
    func prepareForAutoLayout(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        view.subviews.forEach(prepareForAutoLayout)
        backgroundView.subviews.forEach(prepareForAutoLayout)
        
        NSLayoutConstraint.activate([
            userTitleView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16),
            userTitleView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            userTitleView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
            backgroundView.topAnchor.constraint(
                equalTo: userTitleView.bottomAnchor,
                constant: 16),
            backgroundView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            backgroundView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
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
            logoutButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)    
        ])
    }
}
