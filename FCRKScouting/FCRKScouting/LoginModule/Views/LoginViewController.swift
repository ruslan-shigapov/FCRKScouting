//
//  LoginViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 04.03.2024.
//

import AuthenticationServices

final class LoginViewController: UIViewController {
    
    // MARK: Private Properties
    private var viewModel: LoginViewModel
    private var authManager: AuthManager?
        
    // MARK: Views
    private let logoImageView = UIImageView(image: Constants.Images.logo)

    private let appNameLabel = CustomLabel(
        font: Constants.Fonts.title,
        text: Constants.Texts.appName)

    private let accessKeyTextFieldView = PrimaryTextFieldView(
        placeholder: Constants.Texts.Placeholders.accessKey,
        type: .key)
    
    private lazy var accessKeyStackView = StackViewWithDescription(
        mainView: accessKeyTextFieldView,
        text: Constants.Texts.Descriptions.access)
    
    private lazy var appleIDSignInButton: ASAuthorizationAppleIDButton = {
        $0.cornerRadius = 12
        $0.addTarget(
            self,
            action: #selector(appleSignInButtonTapped),
            for: .touchUpInside)
        return $0
    }(ASAuthorizationAppleIDButton(type: .signIn, style: .white))
    
    private lazy var signInStackView = StackViewWithDescription(
        mainView: appleIDSignInButton,
        text: Constants.Texts.Descriptions.signIn)
    
    private lazy var interactiveStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 32
        return $0
    }(UIStackView(arrangedSubviews: [accessKeyStackView, signInStackView]))
    
    private let activityIndicator = LargeActivityIndicatorView()
    
    // MARK: Initialize
    init(viewModel: LoginViewModel) {
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
        handleErrors()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        appleIDSignInButton.setupShadow()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        view.backgroundColor = .rubin
        view.setKeyboardDismissTap()
        view.addSubviews(
            logoImageView,
            appNameLabel,
            interactiveStackView,
            activityIndicator)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func handleErrors() {
        viewModel.wasAccessKeyWrong = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getAlertController(
                withTitle: Constants.Texts.Alerts.wrongAccessKey.title,
                andMessage: Constants.Texts.Alerts.wrongAccessKey.message)
            present(alertController, animated: true)
            resetUI()
        }
        viewModel.wasSomethingWrong = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getAlertController(
                withTitle: Constants.Texts.Alerts.wrongSomething.title,
                andMessage: Constants.Texts.Alerts.wrongSomething.message)
            present(alertController, animated: true)
            resetUI()
        }
    }
    
    private func resetUI() {
        activityIndicator.stopAnimating()
        appleIDSignInButton.isEnabled = true
    }
    
    private func showMainTabBarController() {
        let mainTabBarController = ScreenFactory.getMainTabBarController()
        present(mainTabBarController, animated: false)
    }
    
    // MARK: Actions
    @objc private func appleSignInButtonTapped() {
        let inputText = accessKeyTextFieldView.getInputText()
        activityIndicator.startAnimating()
        appleIDSignInButton.isEnabled = false
        viewModel.logIn(byAccessKey: inputText) { [weak self] in
            guard let self else { return }
            authManager = AuthManager(isEditingAllowed: $0)
            authManager?.singInWithApple {
                switch $0 {
                case .success():
                    self.showMainTabBarController()
                case .failure(_):
                    let alertController = AlertFactory.getAlertController(
                        withTitle: Constants.Texts.Alerts.authError.title,
                        andMessage: Constants.Texts.Alerts.authError.message)
                    self.present(alertController, animated: true)
                }
                self.resetUI()
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
            
            interactiveStackView.topAnchor.constraint(
                equalTo: appNameLabel.bottomAnchor,
                constant: 24),
            interactiveStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 48),
            interactiveStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -48),
            interactiveStackView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            
            appleIDSignInButton.heightAnchor.constraint(
                equalTo: accessKeyTextFieldView.heightAnchor)
        ])
    }
}
