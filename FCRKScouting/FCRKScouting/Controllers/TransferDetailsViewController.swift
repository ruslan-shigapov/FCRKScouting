//
//  TransferDetailsViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 24.05.2024.
//

import UIKit

final class TransferDetailsViewController: UIViewController {
        
    private let titleLabel = CustomWhiteLabel(
        font: Constants.Fonts.header,
        text: Constants.Text.transferDetails)
    
    private let costLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        numberOfLines: 2,
        text: "Стоимость перехода:")
    private let salaryLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        numberOfLines: 2,
        text: "Зарплата игрока:")
    private let contractLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        numberOfLines: 2,
        text: "Окончание контракта:")
    
    private let costTextFieldView = PriceTextFieldView()
    private let salaryTextFieldView = PriceTextFieldView()
    
    private let contractDatePickerView = DatePickerView(type: .contract)
    
    private let agentNameTextFieldView = PrimaryTextFieldView(
        placeholder: "Агент (необязательно)",
        type: .name)
    private let contactsTextFieldView = PrimaryTextFieldView(
        placeholder: "Контакты (необязательно)",
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.textAlignment = .center
        titleLabel.textColor = .systemGreen
        configureTextFields()
        view.backgroundColor = .accent
        view.setupKeyboardDismissTap()
        view.addSubviews(
            titleLabel,
            costLabel,
            costTextFieldView,
            salaryLabel,
            salaryTextFieldView,
            contractLabel,
            contractDatePickerView,
            textFieldStackView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func configureTextFields() {
        // TODO: возможно везде придется вместо делегатов исп вью модели, потому что из других мест будет затруднительно так обращаться, чтобы заполнять текст поля
    }
}
    
private extension TransferDetailsViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 24),
            titleLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            
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
            salaryLabel.widthAnchor.constraint(
                equalToConstant: 120),
            salaryLabel.centerYAnchor.constraint(
                equalTo: salaryTextFieldView.centerYAnchor,
                constant: 2),
            
            salaryTextFieldView.topAnchor.constraint(
                equalTo: costTextFieldView.bottomAnchor,
                constant: 24),
            salaryTextFieldView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
            contractLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            contractLabel.widthAnchor.constraint(
                equalToConstant: 120),
            contractLabel.centerYAnchor.constraint(
                equalTo: contractDatePickerView.centerYAnchor,
                constant: 2),
            
            contractDatePickerView.topAnchor.constraint(
                equalTo: salaryTextFieldView.bottomAnchor,
                constant: 24),
            contractDatePickerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
            textFieldStackView.topAnchor.constraint(
                equalTo: contractDatePickerView.bottomAnchor,
                constant: 24),
            textFieldStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 48),
            textFieldStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -48)
        ])
    }
}
