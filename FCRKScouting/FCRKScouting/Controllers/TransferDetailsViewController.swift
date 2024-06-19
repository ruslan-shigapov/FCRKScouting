//
//  TransferDetailsViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 24.05.2024.
//

import UIKit

final class TransferDetailsViewController: UIViewController {
    
    // MARK: Private Properties
    private var delegate: TransferDetailsViewControllerDelegate?
        
    // MARK: Views
    private let titleLabel = CustomWhiteLabel(
        font: Constants.Fonts.header,
        text: Constants.Text.transferDetails)
    
    private let costLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        numberOfLines: 2,
        text: Constants.Text.cost)
    private let salaryLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        numberOfLines: 2,
        text: Constants.Text.salary)
    private let contractLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        numberOfLines: 2,
        text: Constants.Text.contract)
    
    private let costTextFieldView = PriceTextFieldView()
    private let salaryTextFieldView = PriceTextFieldView()
    
    private lazy var contractDateSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.backgroundColor = .lightGray
        switcher.layer.cornerRadius = 16
        switcher.addTarget(
            self,
            action: #selector(contractDateSwitcherChanged),
            for: .valueChanged)
        return switcher
    }()
    
    private let contractDatePickerView = DatePickerView(type: .contract)
    
    private let agentNameTextFieldView = PrimaryTextFieldView(
        placeholder: Constants.Text.Placeholders.agentName,
        type: .name)
    private let contactsTextFieldView = PrimaryTextFieldView(
        placeholder: Constants.Text.Placeholders.contacts,
        type: .phone)
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [agentNameTextFieldView, contactsTextFieldView])
        stackView.axis = .vertical
        stackView.spacing = 16
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
    
    // MARK: Initialize
    init(delegate: TransferDetailsViewControllerDelegate?) {
        self.delegate = delegate
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
        titleLabel.textAlignment = .center
        titleLabel.textColor = .systemGreen
        configureTextFields()
        view.backgroundColor = .accent
        view.setKeyboardDismissTap()
        view.addSubviews(
            titleLabel,
            costLabel,
            costTextFieldView,
            salaryLabel,
            salaryTextFieldView,
            contractLabel,
            contractDateSwitcher,
            contractDatePickerView,
            textFieldStackView,
            saveButton)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func configureTextFields() {
        if let prices = delegate?.prices, prices.count == 2 {
            costTextFieldView.set(text: prices[0])
            salaryTextFieldView.set(text: prices[1])
        }
        contractDatePickerView.set(date: delegate?.contractDate ?? Date())
        if let agentInfo = delegate?.agentInfo, agentInfo.count == 2 {
            agentNameTextFieldView.set(text: agentInfo[0])
            contactsTextFieldView.set(text: agentInfo[1])
        }
    }
    
    @objc private func contractDateSwitcherChanged() {
        contractDatePickerView.toggleEnabled()
    }
    
    @objc private func saveButtonTapped() {
        delegate?.prices = [
            costTextFieldView.getInputText(),
            salaryTextFieldView.getInputText()]
        delegate?.contractDate = contractDatePickerView.getDate()
        delegate?.agentInfo = [
            agentNameTextFieldView.getInputText(),
            contactsTextFieldView.getInputText()]
        dismiss(animated: true)
    }
}
    
// MARK: - Layout
private extension TransferDetailsViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            costLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            costLabel.widthAnchor.constraint(
                equalToConstant: 120),
            costLabel.centerYAnchor.constraint(
                equalTo: costTextFieldView.centerYAnchor,
                constant: 2),
            
            costTextFieldView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 24),
            costTextFieldView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
            salaryLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            salaryLabel.widthAnchor.constraint( equalTo: costLabel.widthAnchor),
            salaryLabel.centerYAnchor.constraint(
                equalTo: salaryTextFieldView.centerYAnchor,
                constant: 2),
            
            salaryTextFieldView.topAnchor.constraint(
                equalTo: costTextFieldView.bottomAnchor,
                constant: 16),
            salaryTextFieldView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
            contractLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            contractLabel.widthAnchor.constraint(
                equalTo: costLabel.widthAnchor),
            contractLabel.centerYAnchor.constraint(
                equalTo: contractDatePickerView.centerYAnchor,
                constant: 2),
            
            contractDateSwitcher.trailingAnchor.constraint(
                equalTo: contractDatePickerView.leadingAnchor,
                constant: -10),
            contractDateSwitcher.centerYAnchor.constraint(
                equalTo: contractDatePickerView.centerYAnchor),
            
            contractDatePickerView.topAnchor.constraint(
                equalTo: salaryTextFieldView.bottomAnchor,
                constant: 16),
            contractDatePickerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
            textFieldStackView.topAnchor.constraint(
                equalTo: contractDatePickerView.bottomAnchor,
                constant: 16),
            textFieldStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 48),
            textFieldStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -48),
            
            saveButton.topAnchor.constraint(
                equalTo: textFieldStackView.bottomAnchor,
                constant: 24),
            saveButton.widthAnchor.constraint(
                equalTo: textFieldStackView.widthAnchor),
            saveButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor)
        ])
    }
}
