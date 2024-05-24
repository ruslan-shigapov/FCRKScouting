//
//  FormViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 20.05.2024.
//

import UIKit

final class FormViewController: UIViewController {
    
    // MARK: Private Properties
    private var viewModel: FormViewModelProtocol
    
    // MARK: Views
    private let titleLabel = PrimaryLabel(
        font: Constants.Fonts.title,
        numberOfLines: 2,
        text: Constants.Text.ScreenTitles.form)
    
    private let fullNameTextFieldView = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.fullName,
        type: .name)
    private let postTextFieldView = RoundedTextFieldView(
        placeholder: Constants.Text.Placeholders.post,
        type: .name)
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [fullNameTextFieldView, postTextFieldView])
        stackView.axis = .vertical
        stackView.spacing = 24
        for (index, view) in stackView.subviews.enumerated() {
            if let textFieldView = view as? RoundedTextFieldView {
                textFieldView.set(delegate: self)
                textFieldView.set(tag: index)
            }
        }
        return stackView
    }()
    
    private lazy var nextButton: UIButton = {
        let button = PrimaryButton(
            title: Constants.Text.ButtonTitles.next)
        button.addTarget(
            self,
            action: #selector(nextButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: Initialize
    init(viewModel: FormViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func setupUI() {
        titleLabel.textAlignment = .center
        view.setCustomGradientLayer()
        view.addSubviews(titleLabel, textFieldStackView, nextButton)
        view.prepareForAutoLayout()
        setConstraints()
        setupAlerts()
    }
 
    private func setupAlerts() {
        viewModel.wereRequiredTextFieldsEmpty = { [weak self] in
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.emptyTextFields.title,
                andMessage: Constants.Text.Alerts.emptyTextFields.message)
            self?.present(alertController, animated: true)
        }
        viewModel.wasFullNameIncorrect = { [weak self] in
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.incorrectFullName.title,
                andMessage: Constants.Text.Alerts.incorrectFullName.message)
            self?.present(alertController, animated: true)
        }
    }
    
    @objc private func nextButtonTapped() {
        viewModel.validateInput(
            text: [fullNameTextFieldView.getInputText()]
        ) {
            viewModel.enterBy(
                fullName: $0[0],
                post: postTextFieldView.getInputText()
            ) {
                showMainTabBarController()
            }
        }
    }
    
    private func showMainTabBarController() {
        let mainTabBarController = ScreenFactory.getMainTabBarController()
        present(mainTabBarController, animated: false)
    }
}

// MARK: - Text Field Delegate
extension FormViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.focusNextResponder()
        return true
    }
}

// MARK: - Layout
extension FormViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 24),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            titleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            
            textFieldStackView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 48),
            textFieldStackView.widthAnchor.constraint(
                equalTo: nextButton.widthAnchor),
            textFieldStackView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            
            nextButton.topAnchor.constraint(
                equalTo: textFieldStackView.bottomAnchor,
                constant: 48
            ),
            nextButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 48),
            nextButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -48),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
