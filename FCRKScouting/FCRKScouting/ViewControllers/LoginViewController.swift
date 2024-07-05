//
//  LoginViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 04.03.2024.
//

import AuthenticationServices

final class LoginViewController: UIViewController {
    
    // MARK: Private Properties
    private var viewModel: LoginViewModelProtocol
    private var authManager: AuthManager?
        
    // MARK: Views
    private let logoImageView = UIImageView(image: Constants.Images.logo)
    
    private let appNameLabel = CustomLabel(
        font: Constants.Fonts.title,
        text: Constants.Text.appName)

    private let accessKeyTextFieldView = PrimaryTextFieldView(
        placeholder: Constants.Text.Placeholders.accessKey,
        type: .key)
    
    private let accessDescriptionLabel = CustomLabel(
        font: Constants.Fonts.description,
        text: Constants.Text.Descriptions.access,
        numberOfLines: 2)
    
    private lazy var appleSignInButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .white)
        button.cornerRadius = 12
        button.addTarget(
            self,
            action: #selector(appleSignInButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private let signInDescriptionLabel = CustomLabel(
        font: Constants.Fonts.description,
        text: Constants.Text.Descriptions.signIn,
        numberOfLines: 2)
    
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
        setupUI()
        handleWrongAccessKey()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        appleSignInButton.setupShadow()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        view.backgroundColor = .accent
        view.setKeyboardDismissTap()
        view.addSubviews(
            logoImageView,
            appNameLabel,
            accessKeyTextFieldView,
            accessDescriptionLabel,
            appleSignInButton,
            signInDescriptionLabel)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func handleWrongAccessKey() {
        viewModel.wasAccessKeyWrong = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.wrongAccessKey.title,
                andMessage: Constants.Text.Alerts.wrongAccessKey.message)
            present(alertController, animated: true)
        }
    }
    
    private func showFormViewController() {
        let formVC = ScreenFactory.getFormController(withDelegate: nil)
        formVC.modalPresentationStyle = .fullScreen
        present(formVC, animated: true)
    }
    
    private func showMainTabBarController() {
        let mainTabBarController = ScreenFactory.getMainTabBarController()
        present(mainTabBarController, animated: false)
    }
    
    @objc private func appleSignInButtonTapped() {
        viewModel.logIn(
            byAccessKey: accessKeyTextFieldView.getInputText()
        ) { [weak self] in
            guard let self else { return }
            authManager = AuthManager(isEditingAllowed: $0)
            authManager?.singInWithApple { result in
                switch result {
                case .success(let isNewUser):
                    isNewUser
                    ? self.showFormViewController()
                    : self.showMainTabBarController()
                case .failure(_):
                    let alertController = AlertFactory.getWarningAlert(
                        withTitle: Constants.Text.Alerts.authError.title,
                        andMessage: Constants.Text.Alerts.authError.message)
                    self.present(alertController, animated: true)
                }
            }
        }
    }
}

// MARK: - Layout
private extension LoginViewController {
    
    func setConstraints() {
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
                constant: 24),
            accessKeyTextFieldView.widthAnchor.constraint(
                equalTo: appleSignInButton.widthAnchor),
            accessKeyTextFieldView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            
            accessDescriptionLabel.topAnchor.constraint(
                equalTo: accessKeyTextFieldView.bottomAnchor,
                constant: 8),
            accessDescriptionLabel.leadingAnchor.constraint(
                equalTo: accessKeyTextFieldView.leadingAnchor,
                constant: 5),
            accessDescriptionLabel.trailingAnchor.constraint(
                equalTo: accessKeyTextFieldView.trailingAnchor,
                constant: -5),
            
            appleSignInButton.topAnchor.constraint(
                equalTo: accessKeyTextFieldView.bottomAnchor,
                constant: 72),
            appleSignInButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 48),
            appleSignInButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -48),
            appleSignInButton.heightAnchor.constraint(equalToConstant: 48),
            appleSignInButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            
            signInDescriptionLabel.topAnchor.constraint(
                equalTo: appleSignInButton.bottomAnchor,
                constant: 8),
            signInDescriptionLabel.leadingAnchor.constraint(
                equalTo: appleSignInButton.leadingAnchor,
                constant: 5),
            signInDescriptionLabel.trailingAnchor.constraint(
                equalTo: appleSignInButton.trailingAnchor,
                constant: -5),
        ])
    }
}
