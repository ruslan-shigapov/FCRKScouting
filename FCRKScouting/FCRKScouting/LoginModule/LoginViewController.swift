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
    
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.appName
        label.font = Constants.Fonts.title
        label.textColor = .white
        return label
    }()
    
    private let fullNameTextField = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.fullName,
        type: .name)
    
    private let accessKeyTextField = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.accessKey,
        type: .key,
        tag: 2)
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            fullNameTextField,
            accessKeyTextField
        ])
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.accessDescription
        label.font = .systemFont(ofSize: 12, weight: .thin)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private let loginButton = PrimaryButton(
        title: Constants.Text.ButtonTitles.enter)
    
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
        setupTextFields()
        setupButtons()
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
                andMessage: Constants.Text.Alerts.emptyTextField.message)
            self?.present(alertController, animated: true)
        }
        viewModel.wasFullNameIncorrect = { [weak self] in
            let alertController = AlertFactory.getAlert(
                withTitle: Constants.Text.Alerts.incorrectFullName.title,
                andMessage: Constants.Text.Alerts.incorrectFullName.message)
            self?.present(alertController, animated: true)
        }
        viewModel.wasAccessKeyWrong = { [weak self] in
            let alertController = AlertFactory.getAlert(
                withTitle: Constants.Text.Alerts.wrongAccessKey.title,
                andMessage: Constants.Text.Alerts.wrongAccessKey.message)
            self?.present(alertController, animated: true)
        }
        viewModel.didReceiveDataError = { [weak self] in
            let alertController = AlertFactory.getAlert(
                withTitle: Constants.Text.Alerts.wrongSomething.title,
                andMessage: Constants.Text.Alerts.wrongSomething.message)
            self?.present(alertController, animated: true)
        }
    }
    
    private func setupTextFields() {
        textFieldStackView.subviews.forEach {
            if let textFieldView = $0 as? RoundedTextFieldView {
                textFieldView.setDelegate(self)
                setupShadow(forView: textFieldView)
            }
        }
    }
    
    private func setupShadow(forView view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 7
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 10, height: -10)
    }
    
    private func setupButtons() {
        loginButton.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside)
        
        let toolbar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)
        let toolbarLoginButton = UIBarButtonItem(
            title: Constants.Text.ButtonTitles.enter,
            style: .plain,
            target: self,
            action: #selector(loginButtonTapped))
        toolbar.setItems([flexibleSpace, toolbarLoginButton], animated: false)
        toolbar.sizeToFit()
        
        accessKeyTextField.subviews.forEach {
            $0.subviews.forEach {
                if let textField = $0 as? UITextField {
                    textField.inputAccessoryView = toolbar
                }
            }
        }
    }
    
    @objc private func loginButtonTapped() {
        viewModel.validateInput(
            fullName: fullNameTextField.getInputText(),
            accessKey: accessKeyTextField.getInputText()
        ) {
            viewModel.signUp(byFullName: $0, accessKey: $1) {
                showMainScreen()
            }
        }
    }
    
    private func showMainScreen() {
        viewModel.logIn {
            let mainVC = ScreenFactory.getMainViewController(forUser: $0)
            mainVC.modalPresentationStyle = .fullScreen
            present(mainVC, animated: true)
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
private extension LoginViewController {
    
    func prepareForAutoLayout(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        view.subviews.forEach(prepareForAutoLayout)
        
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
            appNameLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            
            textFieldStackView.topAnchor.constraint(
                equalTo: appNameLabel.bottomAnchor,
                constant: 32),
            textFieldStackView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: textFieldStackView.bottomAnchor,
                constant: 5),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: textFieldStackView.leadingAnchor,
                constant: 5),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: textFieldStackView.trailingAnchor,
                constant: -5),
            
            loginButton.topAnchor.constraint(
                equalTo: textFieldStackView.bottomAnchor,
                constant: 80),
            loginButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor)
        ])
    }
}
