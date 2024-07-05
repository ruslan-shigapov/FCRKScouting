//
//  TestingDetailsViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 24.05.2024.
//

import UIKit

final class TestingDetailsViewController: UIViewController {
    
    // MARK: Private Properties
    private var delegate: TestingDetailsViewControllerDelegate?
    
    // MARK: Views
    private let titleLabel: CustomLabel = {
        let label = CustomLabel(
            font: Constants.Fonts.header,
            text: Constants.Text.testingDetails)
        label.textAlignment = .center
        label.textColor = .systemGreen
        return label
    }()
    
    private let dateLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.date)
    private let normativeLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.normative)
    
    private let testingDatePickerView = DatePickerView(type: .standard)
    
    private let runningFor15MLabel = DefaultTextLabel(
        text: Constants.Text.Titles.runningFor15M)
    private let runningFor30MLabel = DefaultTextLabel(
        text: Constants.Text.Titles.runningFor30M)
    private let longJumpLabel = DefaultTextLabel(
        text: Constants.Text.Titles.longJump)
    private let highJumpLabel = DefaultTextLabel(
        text: Constants.Text.Titles.highJump)
    
    private let runningFor15MTextFieldView = DecimalTextFieldView(type: .time)
    private let runningFor30MTextFieldView = DecimalTextFieldView(type: .time)
    private let longJumpTextFieldView = DecimalTextFieldView(type: .meters)
    private let highJumpTextFieldView = DecimalTextFieldView(type: .meters)
    
    private let runningFor15MScoreView = ScoreTextFieldView()
    private let runningFor30MScoreView = ScoreTextFieldView()
    private let longJumpScoreView = ScoreTextFieldView()
    private let highJumpScoreView = ScoreTextFieldView()
    
    private let descriptionLabel = CustomLabel(
        font: Constants.Fonts.description,
        text: Constants.Text.Descriptions.forGoalkeepers)
    
    private let summaryTextViewWithTitle = TextViewWithTitle(
        Constants.Text.Titles.summary)
    
    private lazy var saveButton: PrimaryButton = {
        let button = PrimaryButton(
            title: Constants.Text.ButtonTitles.save)
        button.addTarget(
            self,
            action: #selector(saveButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    // MARK: Initialize
    init(delegate: TestingDetailsViewControllerDelegate?) {
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
        configureUI()
    }
    
    // MARK: Private Methods
    private func setupUI() {
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
    
    private func configureUI() {
        if let results = delegate?.results, results.count == 4 {
            runningFor15MTextFieldView.set(text: results[0])
            runningFor30MTextFieldView.set(text: results[1])
            longJumpTextFieldView.set(text: results[2])
            highJumpTextFieldView.set(text: results[3])
        }
        if let scores = delegate?.scores, scores.count == 4 {
            runningFor15MScoreView.set(text: scores[0])
            runningFor30MScoreView.set(text: scores[1])
            longJumpScoreView.set(text: scores[2])
            highJumpScoreView.set(text: scores[3])
        }
        summaryTextViewWithTitle.set(text: delegate?.summary)
    }
    
    @objc private func saveButtonTapped() {
        view.endEditing(true)
        delegate?.results = [
            runningFor15MTextFieldView.getInputText(),
            runningFor30MTextFieldView.getInputText(),
            longJumpTextFieldView.getInputText(),
            highJumpTextFieldView.getInputText()
        ]
        delegate?.scores = [
            runningFor15MScoreView.getInputText(),
            runningFor30MScoreView.getInputText(),
            longJumpScoreView.getInputText(),
            highJumpScoreView.getInputText()
        ]
        delegate?.summary = summaryTextViewWithTitle.getInputText()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            guard let self else { return }
            dismiss(animated: true)
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
                constant: -2),
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
