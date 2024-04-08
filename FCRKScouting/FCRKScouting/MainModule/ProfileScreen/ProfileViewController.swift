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
    private let userTitleView = PersonTitleView()
    
    private let editButton = EditButton()
    
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
        view.backgroundColor = .systemBackground
        addSubviews()
        setupButtons()
        setConstraints()
        userTitleView.configure(withFullName: viewModel.fullName)
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
        showExitAlert { [weak self] in
            self?.viewModel.logOut()
        }
    }
    
    @objc private func editButtonTapped() {
        showEditAlert(withTitle: Constants.Text.ActionSheets.edit)
    }
}

// MARK: - Alert Controllers
private extension ProfileViewController {
    
    func showEditAlert(withTitle title: String) {
        let alertController = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .actionSheet)
        alertController.setValue(
            NSAttributedString(
                string: title,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 18, weight: .medium)
                ]),
            forKey: "attributedTitle")
        let editPhoto = UIAlertAction(
            title: "Фото профиля",
            style: .default)
        let editFullName = UIAlertAction(
            title: "Имя и фамилию",
            style: .default)
        let cancelAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.cancel,
            style: .cancel)
        alertController.addAction(editPhoto)
        alertController.addAction(editFullName)
        alertController.addAction(cancelAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true)
        }
    }
    
    func showExitAlert(completion: @escaping () -> Void) {
        let alertController = UIAlertController(
            title: Constants.Text.Alerts.exit.title,
            message: Constants.Text.Alerts.exit.message,
            preferredStyle: .alert)
        let allowAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.yes,
            style: .default) { _ in
                completion()
            }
        let cancelAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.no,
            style: .cancel)
        alertController.addAction(allowAction)
        alertController.addAction(cancelAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true)
        }
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
            
            editButton.topAnchor.constraint(
                equalTo: userTitleView.topAnchor,
                constant: 16),
            editButton.trailingAnchor.constraint(
                equalTo: userTitleView.trailingAnchor,
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
