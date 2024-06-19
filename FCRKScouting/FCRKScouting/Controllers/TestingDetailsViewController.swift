//
//  TestingDetailsViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 24.05.2024.
//

import UIKit

final class TestingDetailsViewController: UIViewController {
    
    // MARK: Private Properties
//    private var delegate: TestingDetailsViewControllerDelegate?
    
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
    
    private let runningFor15MLabel = DefaultTextLabel(
        text: Constants.Text.runningFor15M)
    private let runningFor30MLabel = DefaultTextLabel(
        text: Constants.Text.runningFor30M)
    private let longJumpLabel = DefaultTextLabel(text: Constants.Text.longJump)
    private let highJumpLabel = DefaultTextLabel(text: Constants.Text.highJump)
    
    private let runningFor15MTextFieldView = DecimalTextFieldView(
        textFieldType: .time)
    private let runningFor30MTextFieldView = DecimalTextFieldView(
        textFieldType: .time)
    private let longJumpTextFieldView = DecimalTextFieldView(
        textFieldType: .meters)
    private let highJumpTextFieldView = DecimalTextFieldView(
        textFieldType: .meters)
    
    private let runningFor15MScoreView = ScoreTextFieldView()
    private let runningFor30MScoreView = ScoreTextFieldView()
    private let longJumpScoreView = ScoreTextFieldView()
    private let highJumpScoreView = ScoreTextFieldView()
    
    private let descriptionLabel = DescriptionLabel(
        text: Constants.Text.Descriptions.forGoalkeepers)
    
    private let summaryTextViewWithTitle = TextViewWithTitle(
        Constants.Text.summary)
    
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
//    init(delegate: TestingDetailsViewControllerDelegate?) {
//        self.delegate = delegate
//        super.init(nibName: nil, bundle: nil)
//    }
    
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
            runningFor15MLabel,
            runningFor30MLabel,
            longJumpLabel,
            highJumpLabel,
            runningFor15MTextFieldView,
            runningFor30MTextFieldView,
            longJumpTextFieldView,
            highJumpTextFieldView,
            runningFor15MScoreView,
            runningFor30MScoreView,
            longJumpScoreView,
            highJumpScoreView,
            descriptionLabel,
            summaryTextViewWithTitle,
            saveButton)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func configureTextFields() {
//        guard let testingDetails = delegate?.testingDetails,
//                                    testingDetails.count == 7 else { return }
//        heightTextFieldView.set(text: testingDetails[0])
//        weightTextFieldView.set(text: testingDetails[1])
//        let runningDetails = Array(testingDetails[2...4])
//        for (index, view) in runningTextFieldStackView.subviews.enumerated() {
//            if let textFieldView = view as? DecimalTextFieldView {
//                textFieldView.set(text: runningDetails[index])
//            }
//        }
//        longJumpTextFieldView.set(text: testingDetails[5])
//        highJumpTextFieldView.set(text: testingDetails[6])
    }
    
    @objc private func saveButtonTapped() {
        view.endEditing(true)
        
//        delegate?.testingDetails = 
//        
//        let runningDetails = runningTextFieldStackView.subviews.map {
//            ($0 as? DecimalTextFieldView)?.getInputText()
//        }
//        delegate?.testingDetails = [
//            heightTextFieldView.getInputText(),
//            weightTextFieldView.getInputText()
//        ] + runningDetails + [
//            longJumpTextFieldView.getInputText(),
//            highJumpTextFieldView.getInputText()
//        ]
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}

// MARK: - Layout
private extension TestingDetailsViewController {
    
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
                equalTo: runningFor15MTextFieldView.topAnchor,
                constant: -2),
            
            runningFor15MLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            runningFor15MLabel.centerYAnchor.constraint(
                equalTo: runningFor15MTextFieldView.centerYAnchor),
            
            runningFor15MTextFieldView.topAnchor.constraint(
                equalTo: testingDatePickerView.bottomAnchor,
                constant: 16),
            runningFor15MTextFieldView.leadingAnchor.constraint(
                equalTo: highJumpTextFieldView.leadingAnchor),
            
            runningFor30MLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            runningFor30MLabel.centerYAnchor.constraint(
                equalTo: runningFor30MTextFieldView.centerYAnchor),
            
            runningFor30MTextFieldView.topAnchor.constraint(
                equalTo: runningFor15MTextFieldView.bottomAnchor,
                constant: 8),
            runningFor30MTextFieldView.leadingAnchor.constraint(
                equalTo: highJumpTextFieldView.leadingAnchor),
            
            longJumpLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            longJumpLabel.centerYAnchor.constraint(
                equalTo: longJumpTextFieldView.centerYAnchor),
            
            longJumpTextFieldView.topAnchor.constraint(
                equalTo: runningFor30MTextFieldView.bottomAnchor,
                constant: 8),
            longJumpTextFieldView.leadingAnchor.constraint(
                equalTo: highJumpTextFieldView.leadingAnchor),
            
            highJumpLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            highJumpLabel.centerYAnchor.constraint(
                equalTo: highJumpTextFieldView.centerYAnchor),
            
            highJumpTextFieldView.topAnchor.constraint(
                equalTo: longJumpTextFieldView.bottomAnchor,
                constant: 8),
            highJumpTextFieldView.leadingAnchor.constraint(
                equalTo: highJumpLabel.trailingAnchor,
                constant: 12),
            
            runningFor15MScoreView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            runningFor15MScoreView.centerYAnchor.constraint(
                equalTo: runningFor15MTextFieldView.centerYAnchor),
            
            runningFor30MScoreView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            runningFor30MScoreView.centerYAnchor.constraint(
                equalTo: runningFor30MTextFieldView.centerYAnchor),
            
            longJumpScoreView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            longJumpScoreView.centerYAnchor.constraint(
                equalTo: longJumpTextFieldView.centerYAnchor),
            
            highJumpScoreView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            highJumpScoreView.centerYAnchor.constraint(
                equalTo: highJumpTextFieldView.centerYAnchor),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: highJumpLabel.bottomAnchor,
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
                equalToConstant: 140),
            
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
