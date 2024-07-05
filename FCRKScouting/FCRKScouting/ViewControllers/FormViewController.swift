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
    private var delegate: FormViewControllerDelegate?
        
    // MARK: Views
    private lazy var titleLabel: CustomLabel = {
        let labelText = delegate == nil
        ? Constants.Text.ScreenTitles.greeting
        : Constants.Text.ScreenTitles.form
        let label = CustomLabel(
            font: Constants.Fonts.header,
            text: labelText)
        label.textAlignment = .center
        return label
    }()
    
    private let fullNameTextFieldView = PrimaryTextFieldView(
        placeholder: Constants.Text.Placeholders.fullName,
        type: .name)
    
    private lazy var saveButton: PrimaryButton = {
        let button = PrimaryButton(
            title: Constants.Text.ButtonTitles.save)
        button.addTarget(
            self,
            action: #selector(saveButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }

    // MARK: Initialize
    init(
        viewModel: FormViewModelProtocol,
        delegate: FormViewControllerDelegate?
    ) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func setupUI() {
        view.backgroundColor = .accent
        view.setKeyboardDismissTap()
        view.addSubviews(titleLabel, fullNameTextFieldView, saveButton)
        view.prepareForAutoLayout()
        setConstraints()
        setupAlerts()
    }
    
    private func configureUI() {
        fullNameTextFieldView.set(text: viewModel.userFullName)
    }
 
    private func setupAlerts() {
        viewModel.wereRequiredTextFieldsEmpty = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.emptyTextFields.title,
                andMessage: Constants.Text.Alerts.emptyTextFields.message)
            present(alertController, animated: true)
        }
        viewModel.wasFullNameIncorrect = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.incorrectFullName.title,
                andMessage: Constants.Text.Alerts.incorrectFullName.message)
            present(alertController, animated: true)
        }
        viewModel.wasFullNameContainInvalidChars = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Text.Alerts.invalidChars.title,
                andMessage: Constants.Text.Alerts.invalidChars.message)
            present(alertController, animated: true)
        }
    }
    
    private func showMainTabBarController() {
        let mainTabBarController = ScreenFactory.getMainTabBarController()
        present(mainTabBarController, animated: false)
    }
    
    @objc private func saveButtonTapped() {
        viewModel.validateInputText(
            [fullNameTextFieldView.getInputText()]
        ) {
            viewModel.saveUserFullName($0[0]) { [weak self] in
                guard let self else { return }
                if delegate == nil {
                    showMainTabBarController()
                } else {
                    dismiss(animated: true) {
                        self.delegate?.userWasUpdated?()
                    }
                }
            }
        }
    }
}

// MARK: - Layout
private extension FormViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            fullNameTextFieldView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 48),
            fullNameTextFieldView.widthAnchor.constraint(
                equalTo: saveButton.widthAnchor),
            fullNameTextFieldView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            
            saveButton.topAnchor.constraint(
                equalTo: fullNameTextFieldView.bottomAnchor,
                constant: 48
            ),
            saveButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 48),
            saveButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -48),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
