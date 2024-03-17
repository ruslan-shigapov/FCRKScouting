//
//  LoginViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 04.03.2024.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: Views
    private let logoImageView = UIImageView(image: Constants.Images.logo)
    
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.appName
        label.font = Constants.Fonts.title
        label.textColor = .white
        return label
    }()
    
    private let nameTextField = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholder.name,
        type: .name)
    
    private let surnameTextField = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholder.surname,
        type: .name,
        tag: 2)
    
    private let accessKeyTextField = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholder.accessKey,
        type: .key,
        tag: 3)
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameTextField,
            surnameTextField,
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
        title: Constants.Text.ButtonTitle.enter)
    
    // MARK: Dependencies 
    private var viewModel: LoginViewModelProtocol! {
        didSet {
            viewModel.wasAnyTextFieldEmpty = { [weak self] in
                self?.showAlert(
                    withTitle: Constants.Text.Alert.emptyTextField.title,
                    andMessage: Constants.Text.Alert.emptyTextField.message)
            }
            viewModel.wasAccessKeyWrong = { [weak self] in
                self?.showAlert(
                    withTitle: Constants.Text.Alert.wrongAccessKey.title,
                    andMessage: Constants.Text.Alert.wrongAccessKey.message)
            }
            viewModel.didReceiveDataError = { [weak self] in
                self?.showAlert(
                    withTitle: Constants.Text.Alert.wrongSomething.title,
                    andMessage: Constants.Text.Alert.wrongSomething.message)
            }
        }
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel() // TODO: think about it
        setupUI()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        view.backgroundColor = .accent
        addSubviews()
        setDelegates()
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
    
    private func setDelegates() {
        textFieldStackView.subviews.forEach {
            if let textFieldView = $0 as? RoundedTextFieldView {
                textFieldView.setDelegate(self)
            }
        }
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
            title: Constants.Text.ButtonTitle.enter,
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
            name: nameTextField.getInputText(),
            surname: surnameTextField.getInputText(),
            accessKey: accessKeyTextField.getInputText()
        ) {
            viewModel.signUp(byName: $0, surname: $1, accessKey: $2) {
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

// MARK: - Alert Controller
private extension LoginViewController {
    
    func showAlert(withTitle title: String, andMessage message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
}

// MARK: - Layout
private extension LoginViewController {
    
    func prepareForAutoLayout(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        view.subviews.forEach(prepareForAutoLayout)
        view.keyboardLayoutGuide.followsUndockedKeyboard = true // TODO: make dynamic
        
        NSLayoutConstraint.activate([
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
            textFieldStackView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
            
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
                constant: 72),
            loginButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor)
        ])
    }
}
