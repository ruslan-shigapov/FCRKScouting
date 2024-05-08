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
        text: Constants.Text.appName
    )
    
    private let fullNameTextFieldView = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.fullName,
        type: .name
    )
    private let accessKeyTextFieldView = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.accessKey,
        type: .key,
        tag: 2
    )
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                fullNameTextFieldView,
                accessKeyTextFieldView
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.subviews.forEach {
            if let textFieldView = $0 as? RoundedTextFieldView {
                textFieldView.setDelegate(self)
            }
        }
        return stackView
    }()
    
    private let descriptionLabel = DescriptionLabel(
        text: Constants.Text.accessDescription
    )
    
    private lazy var loginButton: UIButton = {
        let button = PrimaryButton(title: Constants.Text.ButtonTitles.enter)
        button.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside
        )
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
        setupUI()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        view.backgroundColor = .accent
        addSubviews()
        setupAlerts()
        setupToolbar()
        setConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(appNameLabel)
        view.addSubview(textFieldStackView)
        view.addSubview(descriptionLabel)
        view.addSubview(loginButton)
    }
    
    private func setupAlerts() {
        viewModel.wasAnyTextFieldEmpty = { [weak self] in
            let alertController = AlertFactory.getAlert(
                withTitle: Constants.Text.Alerts.emptyTextField.title,
                andMessage: Constants.Text.Alerts.emptyTextField.message
            )
            self?.present(alertController, animated: true)
        }
        viewModel.wasFullNameIncorrect = { [weak self] in
            let alertController = AlertFactory.getAlert(
                withTitle: Constants.Text.Alerts.incorrectFullName.title,
                andMessage: Constants.Text.Alerts.incorrectFullName.message
            )
            self?.present(alertController, animated: true)
        }
        viewModel.wasAccessKeyWrong = { [weak self] in
            let alertController = AlertFactory.getAlert(
                withTitle: Constants.Text.Alerts.wrongAccessKey.title,
                andMessage: Constants.Text.Alerts.wrongAccessKey.message
            )
            self?.present(alertController, animated: true)
        }
        viewModel.didReceiveDataError = { [weak self] in
            let alertController = AlertFactory.getAlert(
                withTitle: Constants.Text.Alerts.wrongSomething.title,
                andMessage: Constants.Text.Alerts.wrongSomething.message
            )
            self?.present(alertController, animated: true)
        }
    }
    
    private func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = true
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let loginButton = UIBarButtonItem(
            title: Constants.Text.ButtonTitles.enter,
            style: .plain,
            target: self,
            action: #selector(loginButtonTapped)
        )
        toolbar.items = [flexibleSpace, loginButton]
        accessKeyTextFieldView.subviews.forEach {
            $0.subviews.forEach {
                if let textField = $0 as? UITextField {
                    textField.inputAccessoryView = toolbar
                }
            }
        }
    }
    
    @objc private func loginButtonTapped() {
        viewModel.validateInput(
            text: [
                fullNameTextFieldView.getInputText(),
                accessKeyTextFieldView.getInputText()
            ]
        ) {
            viewModel.signUpBy(fullName: $0[0], accessKey: $0[1]) {
                showMainScreen()
            }
        }
    }
    
    private func showMainScreen() {
        viewModel.logIn {
            let mainTabBarController = ScreenFactory.getMainTabBarController()
            present(mainTabBarController, animated: true)
        }
    }
}

// MARK: - Text Field Delegate
extension LoginViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.superview?.superview?.superview?.viewWithTag(
            textField.tag + 1)?.becomeFirstResponder()
        return true
    }
}

// MARK: - Layout
extension LoginViewController {
    
    private func setConstraints() {
        view.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 24
            ),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            
            appNameLabel.topAnchor.constraint(
                equalTo: logoImageView.bottomAnchor,
                constant: 24
            ),
            appNameLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            
            textFieldStackView.topAnchor.constraint(
                equalTo: appNameLabel.bottomAnchor,
                constant: 32
            ),
            textFieldStackView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: textFieldStackView.bottomAnchor,
                constant: 5
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: textFieldStackView.leadingAnchor,
                constant: 5
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: textFieldStackView.trailingAnchor,
                constant: -5
            ),
            
            loginButton.topAnchor.constraint(
                equalTo: textFieldStackView.bottomAnchor,
                constant: 80
            ),
            loginButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            )
        ])
    }
}
