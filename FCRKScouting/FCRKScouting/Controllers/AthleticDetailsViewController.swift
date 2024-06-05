//
//  AthleticDetailsViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 24.05.2024.
//

import UIKit

final class AthleticDetailsViewController: UIViewController {
    
    // MARK: Private Properties
    private var delegate: AthleticDetailsViewControllerDelegate?
    
    // MARK: Views
    private let titleLabel = CustomWhiteLabel(
        font: Constants.Fonts.header,
        numberOfLines: 2,
        text: Constants.Text.ScreenTitles.athleticDetails)
    
    private let heightLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.height)
    private let weightLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.weight)
    private let normativeLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.normative)
    
    private let heightTextFieldView = DecimalTextFieldView(
        textFieldType: .meters,
        unitTitle: Constants.Text.Units.meter)
    private let weightTextFieldView = DecimalTextFieldView(
        textFieldType: .weight,
        unitTitle: Constants.Text.Units.kilo)
    
    private lazy var runningTextFieldStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                DecimalTextFieldView(textFieldType: .time, unitTitle: ""),
                DecimalTextFieldView(textFieldType: .time,unitTitle: ""),
                DecimalTextFieldView(
                    textFieldType: .time,
                    unitTitle: Constants.Text.Units.second)
            ])
        return stackView
    }()
    
    private let longJumpTextFieldView = DecimalTextFieldView(
        textFieldType: .meters,
        unitTitle: Constants.Text.Units.meter)
    private let highJumpTextFieldView = DecimalTextFieldView(
        textFieldType: .meters,
        unitTitle: Constants.Text.Units.meter)
    
    private lazy var runningNormativeStackView: UIStackView = {
        let label = DefaultGrayLabel(text: Constants.Text.running)
        let spacerView = UIView()
        let stackView = UIStackView(
            arrangedSubviews: [label, spacerView, runningTextFieldStackView])
        return stackView
    }()
    private lazy var longJumpNormativeStackView: UIStackView = {
        let label = DefaultGrayLabel(text: Constants.Text.longJump)
        let spacerView = UIView()
        let stackView = UIStackView(
            arrangedSubviews: [label, spacerView, longJumpTextFieldView])
        return stackView
    }()
    private lazy var highJumpNormativeStackView: UIStackView = {
        let label = DefaultGrayLabel(text: Constants.Text.highJump)
        let spacerView = UIView()
        let stackView = UIStackView(
            arrangedSubviews: [label, spacerView, highJumpTextFieldView])
        return stackView
    }()
    
    private let descriptionLabel = DescriptionLabel(
        text: Constants.Text.Descriptions.forGoalkeepers)
    
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
    init(delegate: AthleticDetailsViewControllerDelegate?) {
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
        view.setupKeyboardDismissTap()
        view.addSubviews(
            titleLabel,
            heightLabel,
            heightTextFieldView,
            weightLabel,
            weightTextFieldView,
            normativeLabel,
            runningNormativeStackView,
            longJumpNormativeStackView,
            highJumpNormativeStackView,
            descriptionLabel,
            saveButton)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func configureTextFields() {
        guard let athleticDetails = delegate?.athleticDetails,
                                    athleticDetails.count == 7 else { return }
        heightTextFieldView.set(text: athleticDetails[0])
        weightTextFieldView.set(text: athleticDetails[1])
        let runningDetails = Array(athleticDetails[2...4])
        for (index, view) in runningTextFieldStackView.subviews.enumerated() {
            if let textFieldView = view as? DecimalTextFieldView {
                textFieldView.set(text: runningDetails[index])
            }
        }
        longJumpTextFieldView.set(text: athleticDetails[5])
        highJumpTextFieldView.set(text: athleticDetails[6])
    }
    
    @objc private func saveButtonTapped() {
        view.endEditing(true)
        let runningDetails = runningTextFieldStackView.subviews.map {
            ($0 as? DecimalTextFieldView)?.getInputText()
        }
        delegate?.athleticDetails = [
            heightTextFieldView.getInputText(),
            weightTextFieldView.getInputText()
        ] + runningDetails + [
            longJumpTextFieldView.getInputText(),
            highJumpTextFieldView.getInputText()
        ]
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) { [weak self] in
            self?.dismiss(animated: true)
        }
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
            
            runningNormativeStackView.topAnchor.constraint(
                equalTo: normativeLabel.bottomAnchor,
                constant: 6),
            runningNormativeStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            runningNormativeStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
            longJumpNormativeStackView.topAnchor.constraint(
                equalTo: runningNormativeStackView.bottomAnchor,
                constant: 16),
            longJumpNormativeStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            longJumpNormativeStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -90),
            
            highJumpNormativeStackView.topAnchor.constraint(
                equalTo: longJumpNormativeStackView.bottomAnchor,
                constant: 16),
            highJumpNormativeStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            highJumpNormativeStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -90),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: highJumpNormativeStackView.bottomAnchor,
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
