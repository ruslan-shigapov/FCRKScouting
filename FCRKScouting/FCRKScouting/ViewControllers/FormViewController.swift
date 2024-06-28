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
    private let titleLabel: UILabel = {
        let label = CustomWhiteLabel(
            font: Constants.Fonts.header,
            text: Constants.Text.ScreenTitles.form)
        label.textAlignment = .center
        return label
    }()
    
    private let fullNameTextFieldView = PrimaryTextFieldView(
        placeholder: Constants.Text.Placeholders.fullName,
        type: .name)
    private let postTextFieldView = PrimaryTextFieldView(
        placeholder: Constants.Text.Placeholders.post,
        type: .name)
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [fullNameTextFieldView, postTextFieldView])
        stackView.axis = .vertical
        stackView.spacing = 24
        for (index, view) in stackView.subviews.enumerated() {
            if let textFieldView = view as? PrimaryTextFieldView {
                textFieldView.set(tag: index)
            }
        }
        return stackView
    }()
    
    private lazy var saveButton: UIButton = {
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
        view.addSubviews(titleLabel, textFieldStackView, saveButton)
        view.prepareForAutoLayout()
        setConstraints()
        setupAlerts()
        configureUI()
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
    }
    
    private func configureUI() {
        fullNameTextFieldView.set(text: viewModel.fullName)
        postTextFieldView.set(text: viewModel.post)
    }
    
    private func runMainTabBarController() {
        let mainTabBarController = ScreenFactory.getMainTabBarController()
        present(mainTabBarController, animated: false)
    }
    
    // MARK: Selectors 
    @objc private func saveButtonTapped() {
        viewModel.validateInput(
            text: [fullNameTextFieldView.getInputText()]
        ) {
            viewModel.saveUserBy(
                fullName: $0[0],
                post: postTextFieldView.getInputText()
            ) { isEditingMode in
                isEditingMode
                ? dismiss(animated: true) { [weak self] in
                    guard let self else { return }
                    self.delegate?.userWasUpdated?()
                } 
                : runMainTabBarController()
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
            
            textFieldStackView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 48),
            textFieldStackView.widthAnchor.constraint(
                equalTo: saveButton.widthAnchor),
            textFieldStackView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            
            saveButton.topAnchor.constraint(
                equalTo: textFieldStackView.bottomAnchor,
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
