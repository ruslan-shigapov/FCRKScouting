//
//  LoginViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 04.03.2024.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: Private Properties
    private var viewModel: LoginViewModelProtocol
    
    // MARK: Views
    private let logoImageView = UIImageView(image: Constants.Images.logo)
    
    private let appNameLabel = CustomWhiteLabel(
        font: Constants.Fonts.title,
        text: Constants.Text.appName)

    private let accessKeyTextFieldView = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.accessKey,
        type: .key)
    
    private let descriptionLabel = DescriptionLabel(
        text: Constants.Text.accessDescription)
    
    private lazy var loginButton: UIButton = {
        let button = PrimaryButton(title: Constants.Text.ButtonTitles.enter)
        button.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    // MARK: Initialize
    init(viewModel: LoginViewModelProtocol) {
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
        accessKeyTextFieldView.set(delegate: self)
        setupUI()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        view.backgroundColor = .accent
        view.addSubviews(
            logoImageView,
            appNameLabel,
            accessKeyTextFieldView,
            descriptionLabel,
            loginButton)
        view.prepareForAutoLayout()
        setConstraints()
        setupAlerts()
    }
    
    private func setupAlerts() {
        viewModel.wasAccessKeyWrong = { [weak self] in
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.wrongAccessKey.title,
                andMessage: Constants.Text.Alerts.wrongAccessKey.message)
            self?.present(alertController, animated: true)
        }
    }
    
    @objc private func loginButtonTapped() {
        viewModel.logInBy(
            accessKey: accessKeyTextFieldView.getInputText()
        ) {
            let formVC = ScreenFactory.getFormController(withAccessValue: $0)
            present(formVC, animated: false)
        }
    }
}

// MARK: - Text Field Delegate
extension LoginViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

// MARK: - Layout
extension LoginViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 24),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            
            appNameLabel.topAnchor.constraint(
                equalTo: logoImageView.bottomAnchor,
                constant: 24),
            appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            accessKeyTextFieldView.topAnchor.constraint(
                equalTo: appNameLabel.bottomAnchor,
                constant: 32),
            accessKeyTextFieldView.widthAnchor.constraint(
                equalTo: loginButton.widthAnchor),
            accessKeyTextFieldView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: accessKeyTextFieldView.bottomAnchor,
                constant: 8),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: accessKeyTextFieldView.leadingAnchor,
                constant: 5),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: accessKeyTextFieldView.trailingAnchor,
                constant: -5),
            
            loginButton.topAnchor.constraint(
                equalTo: accessKeyTextFieldView.bottomAnchor,
                constant: 70),
            loginButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 48),
            loginButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -48),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
