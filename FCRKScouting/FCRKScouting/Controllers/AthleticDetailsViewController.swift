//
//  AthleticDetailsViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 24.05.2024.
//

import UIKit

final class AthleticDetailsViewController: UIViewController {
    
    // MARK: Views
    private let titleLabel = CustomLabel(
        font: Constants.Fonts.header,
        numberOfLines: 2,
        text: "Антропометрия и \n Атлетические данные")
    
    private let heightLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: "Рост:")
    private let weightLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: "Вес:")
    private let normativeLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: "Нормативы:")
    
    private let heightTextFieldView = DecimalTextFieldView(
        textFieldType: .meters,
        unitTitle: "м")
    private let weightTextFieldView = DecimalTextFieldView(
        textFieldType: .weight,
        unitTitle: "кг")
    
    private lazy var runningTextFieldStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                DecimalTextFieldView(textFieldType: .time, unitTitle: ""),
                DecimalTextFieldView(textFieldType: .time,unitTitle: ""),
                DecimalTextFieldView(textFieldType: .time, unitTitle: "сек")
            ])
        return stackView
    }()
    
    private let longJumpTextFieldView = DecimalTextFieldView(
        textFieldType: .meters,
        unitTitle: "м")
    private let highJumpTextFieldView = DecimalTextFieldView(
        textFieldType: .meters,
        unitTitle: "м")
    
    private lazy var runningStackView = NormativeStackView(
        title: "Бег на 5/15/30м",
        textFieldView: runningTextFieldStackView)
    private lazy var longJumpStackView = NormativeStackView(
        title: "Прыжок с места",
        textFieldView: longJumpTextFieldView)
    private lazy var highJumpStackView = NormativeStackView(
        title: "Прыжок в высоту",
        textFieldView: highJumpTextFieldView)
    
    private let descriptionLabel = DescriptionLabel(text: "(для вратарей)")
    
    private let saveButton = PrimaryButton(
        title: Constants.Text.ButtonTitles.save)

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        titleLabel.textAlignment = .center
        titleLabel.textColor = .systemGreen
        view.backgroundColor = .accent
        view.setupKeyboardDismissTap()
        view.addSubviews(
            titleLabel,
            heightLabel,
            heightTextFieldView,
            weightLabel,
            weightTextFieldView,
            normativeLabel,
            runningStackView,
            longJumpStackView,
            highJumpStackView,
            descriptionLabel,
            saveButton)
        view.prepareForAutoLayout()
        setConstraints()
    }
}

// MARK: - Layout
private extension AthleticDetailsViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            heightLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            heightLabel.centerYAnchor.constraint(
                equalTo: heightTextFieldView.centerYAnchor),
            
            heightTextFieldView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 24),
            heightTextFieldView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -90),
            
            weightLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            weightLabel.centerYAnchor.constraint(
                equalTo: weightTextFieldView.centerYAnchor),
            
            weightTextFieldView.topAnchor.constraint(
                equalTo: heightTextFieldView.bottomAnchor,
                constant: 16),
            weightTextFieldView.leadingAnchor.constraint(
                equalTo: heightTextFieldView.leadingAnchor),
            
            normativeLabel.topAnchor.constraint(
                equalTo: weightTextFieldView.bottomAnchor,
                constant: 22),
            normativeLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            
            runningStackView.topAnchor.constraint(
                equalTo: normativeLabel.bottomAnchor,
                constant: 6),
            runningStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            runningStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
            longJumpStackView.topAnchor.constraint(
                equalTo: runningStackView.bottomAnchor,
                constant: 16),
            longJumpStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            longJumpStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -90),
            
            highJumpStackView.topAnchor.constraint(
                equalTo: longJumpStackView.bottomAnchor,
                constant: 16),
            highJumpStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            highJumpStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -90),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: highJumpStackView.bottomAnchor,
                constant: -5),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            
            saveButton.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: 24),
            saveButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            saveButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16)
        ])
    }
}
