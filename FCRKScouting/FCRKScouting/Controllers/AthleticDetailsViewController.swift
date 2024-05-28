//
//  AthleticDetailsViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 24.05.2024.
//

import UIKit

final class AthleticDetailsViewController: UIViewController {
    
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
    
    private lazy var containerStackView: UIStackView = {
        let runningFiveMetersStackView = NormativeStackView(
            label: DefaultLabel(text: "Бег на 5 м."),
            textField: UITextField())
        let runningFifteenMetersStackView = NormativeStackView(
            label: DefaultLabel(text: "Бег на 15 м."),
            textField: UITextField())
        let runningThirtyMetersStackView = NormativeStackView(
            label: DefaultLabel(text: "Бег на 30 м."),
            textField: UITextField())
        let longJumpStackView = NormativeStackView(
            label: DefaultLabel(text: "Прыжок с места"),
            textField: UITextField())
        let highJumpStackView = NormativeStackView(
            label: DefaultLabel(text: "Прыжок в высоту"),
            textField: UITextField())
        let stackView = UIStackView(
            arrangedSubviews: [
                runningFiveMetersStackView,
                runningFifteenMetersStackView,
                runningThirtyMetersStackView,
                longJumpStackView,
                highJumpStackView
            ])
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private let descriptionLabel = DescriptionLabel(text: "(для вратарей)")

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.textAlignment = .center
        titleLabel.textColor = .systemGreen
        view.backgroundColor = .accent
        view.addSubviews(
            titleLabel,
            heightLabel,
            weightLabel,
            normativeLabel,
            containerStackView,
            descriptionLabel)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 32),
            titleLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            
            heightLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 32),
            heightLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            
            weightLabel.topAnchor.constraint(
                equalTo: heightLabel.bottomAnchor,
                constant: 32),
            weightLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            
            normativeLabel.topAnchor.constraint(
                equalTo: weightLabel.bottomAnchor,
                constant: 32),
            normativeLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            
            containerStackView.topAnchor.constraint(
                equalTo: normativeLabel.bottomAnchor,
                constant: 12),
            containerStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            containerStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: containerStackView.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24)
        ])
    }
}
