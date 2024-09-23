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
    private var delegate: FormViewControllerDelegate
        
    // MARK: Views
    private let titleLabel: CustomLabel = {
        let label = CustomLabel(
            font: Constants.Fonts.header,
            text: Constants.Texts.ScreenTitles.form,
            color: .rubin)
        label.textAlignment = .center
        return label
    }()
    
    private let fullNameTextFieldView = PrimaryTextFieldView(
        placeholder: Constants.Texts.Placeholders.fullName,
        type: .name)
    
    private let fullNameDescriptionLabel = CustomLabel(
        font: Constants.Fonts.description,
        text: Constants.Texts.Descriptions.fullName,
        numberOfLines: 2)
    
    private lazy var saveButton: PrimaryButton = {
        let button = PrimaryButton(
            title: Constants.Texts.ButtonTitles.save)
        button.addTarget(
            self,
            action: #selector(saveButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    private lazy var infoStackView = AppInfoStackView()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }

    // MARK: Initialize
    init(
        delegate: FormViewControllerDelegate,
        viewModel: FormViewModelProtocol
    ) {
        self.delegate = delegate
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func setupUI() {
        setKeyboardDismissTap()
        view.backgroundColor = .deepGreen
        view.addSubviews(
            titleLabel,
            fullNameTextFieldView,
            fullNameDescriptionLabel,
            saveButton,
            infoStackView)
        view.prepareForAutoLayout()
        setConstraints()
        setupAlerts()
    }
    
    private func configureUI() {
        fullNameTextFieldView.set(text: viewModel.userFullName)
    }
    
    private func setKeyboardDismissTap() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
 
    private func setupAlerts() {
        viewModel.wereRequiredTextFieldsEmpty = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Texts.Alerts.emptyTextFields.title,
                andMessage: Constants.Texts.Alerts.emptyTextFields.message)
            present(alertController, animated: true)
        }
        viewModel.wasFullNameIncorrect = { [weak self] in
            guard let self else { return }
            let alertController = AlertFactory.getWarningAlert(
                withTitle: Constants.Texts.Alerts.incorrectFullName.title,
                andMessage: Constants.Texts.Alerts.incorrectFullName.message)
            present(alertController, animated: true)
        }
    }
    
    private func showMainTabBarController() {
        let mainTabBarController = ScreenFactory.getMainTabBarController()
        present(mainTabBarController, animated: false)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func saveButtonTapped() {
        viewModel.validateInputText(
            [fullNameTextFieldView.getInputText()]
        ) {
            viewModel.saveUserFullName($0[0]) { [weak self] in
                guard let self else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.dismiss(animated: true) {
                        self.delegate.userWasUpdated?()
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
                constant: 24),
            fullNameTextFieldView.widthAnchor.constraint(
                equalTo: saveButton.widthAnchor),
            fullNameTextFieldView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
                        
            fullNameDescriptionLabel.topAnchor.constraint(
                equalTo: fullNameTextFieldView.bottomAnchor,
                constant: 8),
            fullNameDescriptionLabel.leadingAnchor.constraint(
                equalTo: fullNameTextFieldView.leadingAnchor,
                constant: 5),
            fullNameDescriptionLabel.trailingAnchor.constraint(
                equalTo: fullNameTextFieldView.trailingAnchor,
                constant: -5),
            
            saveButton.topAnchor.constraint(
                equalTo: fullNameTextFieldView.bottomAnchor,
                constant: 48),
            saveButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 48),
            saveButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -48),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            infoStackView.leadingAnchor.constraint(
                equalTo: saveButton.leadingAnchor),
            infoStackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -24)
        ])
    }
}
