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
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 12, weight: .thin)
        label.textColor = .white
        return label
    }()
    
    private let loginButton = PrimaryButton(
        title: Constants.Text.ButtonTitle.enter)
    
    // MARK: Dependencies
    private let viewModel: LoginViewModelProtocol
    
    
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
        
        loginButton.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside)
        
        // TODO: вынести создание кнопки в отдельный метод
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let returnButton = UIBarButtonItem(title: "Войти", style: .done, target: self, action: #selector(toolBarButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, returnButton], animated: false)
        accessKeyTextField.subviews.forEach {
            $0.subviews.forEach {
                if let textField = $0 as? UITextField {
                    textField.inputAccessoryView = toolbar
                }
            }
        }
    }
    
    // MARK: Private Methods
    private func setupUI() {
        view.backgroundColor = .accent
        addSubviews()
        setDelegates()
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
    
    @objc private func loginButtonTapped() {
        
//        viewModel.logIn(
//            byName: firstNameTextField.getText(),
//            surname: secondNameTextField.getText(),
//            accessKey: accessKeyTextField.getText()
//        ) {
//            // TODO: показать алерт 
//        }
        showMainScreen()
    }
    
    @objc private func toolBarButtonTapped() {}
    
    private func showMainScreen() {
        let mainVC = ModuleFactory.shared.getMainViewController()
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true)
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
    
    private func prepareForAutoLayout(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        view.subviews.forEach(prepareForAutoLayout)
        view.keyboardLayoutGuide.followsUndockedKeyboard = true // TODO: доделать
        
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
