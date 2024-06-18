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
        text: Constants.Text.testingDetails)
    
    private let normativeLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.normative)
    private let dateLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.date)
    
    private let testingDatePickerView = DatePickerView(type: .standard)
    
    private let runningFor15MTextFieldView = DecimalTextFieldView(
        textFieldType: .time)
    private let runningFor30MTextFieldView = DecimalTextFieldView(
        textFieldType: .time)
    private let longJumpTextFieldView = DecimalTextFieldView(
        textFieldType: .meters)
    private let highJumpTextFieldView = DecimalTextFieldView(
        textFieldType: .meters)
    
    private lazy var runningFor15MNormativeStackView: UIStackView = {
        let label = DefaultTextLabel(text: Constants.Text.runningFor15M)
        let spacerView = UIView()
        let stackView = UIStackView(
            arrangedSubviews: [label, runningFor15MTextFieldView])
        stackView.distribution = .fillProportionally
        return stackView
    }()
    private lazy var runningFor30MNormativeStackView: UIStackView = {
        let label = DefaultTextLabel(text: Constants.Text.runningFor30M)
        let stackView = UIStackView(
            arrangedSubviews: [label, runningFor30MTextFieldView])
        return stackView
    }()
    private lazy var longJumpNormativeStackView: UIStackView = {
        let label = DefaultTextLabel(text: Constants.Text.longJump)
        let stackView = UIStackView(
            arrangedSubviews: [label, longJumpTextFieldView])
        return stackView
    }()
    private lazy var highJumpNormativeStackView: UIStackView = {
        let label = DefaultTextLabel(text: Constants.Text.highJump)
        let stackView = UIStackView(
            arrangedSubviews: [label, highJumpTextFieldView])
        return stackView
    }()
    
    private let descriptionLabel = DescriptionLabel(
        text: Constants.Text.Descriptions.forGoalkeepers)
    
    private let summaryTextViewWithTitle = TextViewWithTitle("Выводы:")
    
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
        view.setKeyboardDismissTap()
        view.addSubviews(
            titleLabel,
            normativeLabel,
            dateLabel,
            testingDatePickerView,
            runningFor15MNormativeStackView,
            runningFor30MNormativeStackView,
            longJumpNormativeStackView,
            highJumpNormativeStackView,
            descriptionLabel,
            summaryTextViewWithTitle,
            saveButton)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func configureTextFields() {
//        guard let athleticDetails = delegate?.athleticDetails,
//                                    athleticDetails.count == 7 else { return }
//        heightTextFieldView.set(text: athleticDetails[0])
//        weightTextFieldView.set(text: athleticDetails[1])
//        let runningDetails = Array(athleticDetails[2...4])
//        for (index, view) in runningTextFieldStackView.subviews.enumerated() {
//            if let textFieldView = view as? DecimalTextFieldView {
//                textFieldView.set(text: runningDetails[index])
//            }
//        }
//        longJumpTextFieldView.set(text: athleticDetails[5])
//        highJumpTextFieldView.set(text: athleticDetails[6])
    }
    
    @objc private func saveButtonTapped() {
//        view.endEditing(true)
//        let runningDetails = runningTextFieldStackView.subviews.map {
//            ($0 as? DecimalTextFieldView)?.getInputText()
//        }
//        delegate?.athleticDetails = [
//            heightTextFieldView.getInputText(),
//            weightTextFieldView.getInputText()
//        ] + runningDetails + [
//            longJumpTextFieldView.getInputText(),
//            highJumpTextFieldView.getInputText()
//        ]
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
//            self?.dismiss(animated: true)
//        }
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
            
            dateLabel.trailingAnchor.constraint(
                equalTo: testingDatePickerView.leadingAnchor,
                constant: -10),
            dateLabel.centerYAnchor.constraint(
                equalTo: testingDatePickerView.centerYAnchor,
                constant: 1),
            
            testingDatePickerView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 10),
            testingDatePickerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
            normativeLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            normativeLabel.bottomAnchor.constraint(
                equalTo: runningFor15MNormativeStackView.topAnchor,
                constant: -2),
            
            runningFor15MNormativeStackView.topAnchor.constraint(
                equalTo: testingDatePickerView.bottomAnchor,
                constant: 16),
            runningFor15MNormativeStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            runningFor15MNormativeStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
            runningFor30MNormativeStackView.topAnchor.constraint(
                equalTo: runningFor15MNormativeStackView.bottomAnchor,
                constant: 8),
            runningFor30MNormativeStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            runningFor30MTextFieldView.leadingAnchor.constraint(
                equalTo: runningFor15MTextFieldView.leadingAnchor),
            
            longJumpNormativeStackView.topAnchor.constraint(
                equalTo: runningFor30MNormativeStackView.bottomAnchor,
                constant: 8),
            longJumpNormativeStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            longJumpTextFieldView.leadingAnchor.constraint(
                equalTo: runningFor30MTextFieldView.leadingAnchor),
            
            highJumpNormativeStackView.topAnchor.constraint(
                equalTo: longJumpNormativeStackView.bottomAnchor,
                constant: 8),
            highJumpNormativeStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            highJumpTextFieldView.leadingAnchor.constraint(
                equalTo: runningFor30MTextFieldView.leadingAnchor),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: highJumpNormativeStackView.bottomAnchor,
                constant: -5),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            
            summaryTextViewWithTitle.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: 16),
            summaryTextViewWithTitle.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            summaryTextViewWithTitle.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: 4),
            summaryTextViewWithTitle.heightAnchor.constraint(
                equalToConstant: 120),
            
            saveButton.topAnchor.constraint(
                equalTo: summaryTextViewWithTitle.bottomAnchor),
            saveButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            saveButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16)
        ])
    }
}
