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
    
    private let nameLabel: UILabel = {
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
        type: .name)
    
    private let accessKeyTextField = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholder.accessKey,
        type: .key)
    
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

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Methods
    private func setupUI() {
        view.backgroundColor = .accent
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(nameLabel)
        view.addSubview(textFieldStackView)
        view.addSubview(descriptionLabel)
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
            logoImageView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(
                equalTo: logoImageView.bottomAnchor,
                constant: 24),
            nameLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            
            textFieldStackView.topAnchor.constraint(
                equalTo: nameLabel.bottomAnchor,
                constant: 48),
            textFieldStackView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: accessKeyTextField.bottomAnchor,
                constant: 5),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: accessKeyTextField.leadingAnchor,
                constant: 5),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: accessKeyTextField.trailingAnchor,
                constant: -5)
        ])
    }
}

