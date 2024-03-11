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
    
    private let firstNameTextField = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholder.firstName,
        type: .name)
    
    private let secondNameTextField = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholder.secondName,
        type: .name,
        tag: 2)
    
    private let accessKeyTextField = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholder.accessKey,
        type: .key,
        tag: 3)
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            firstNameTextField,
            secondNameTextField,
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
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle(Constants.Text.ButtonTitle.enter, for: .normal)
        button.setTitleColor(.accent, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside)
        return button
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
        showMainScreen()
    }
    
    private func showMainScreen() {
        print("dsfdsf")
    }
}

// MARK: - Text Field Delegate
extension LoginViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTF = textField.superview?.superview?.superview?.viewWithTag(
            textField.tag + 1)
        if let nextResponder = nextTF {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            showMainScreen()
        }
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
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 24),
            logoImageView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            
            appNameLabel.topAnchor.constraint(
                equalTo: logoImageView.bottomAnchor,
                constant: 24),
            appNameLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            
            textFieldStackView.topAnchor.constraint(
                equalTo: appNameLabel.bottomAnchor,
                constant: 48),
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
                equalTo: descriptionLabel.bottomAnchor,
                constant: 48),
            loginButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 120),
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

