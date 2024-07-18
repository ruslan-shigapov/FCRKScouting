//
//  PlayerExtraCard.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 05.07.2024.
//

import UIKit

final class PlayerExtraCard: UIView {
    
    // MARK: Views
    private let titleLabel: CustomLabel = {
        let label = CustomLabel(
            font: Constants.Fonts.header,
            text: Constants.Text.ScreenTitles.extraInfo,
            numberOfLines: 2, 
            color: .accent)
        label.textAlignment = .center
        return label
    }()
    
    private let costLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.cost,
        numberOfLines: 2)
    private let salaryLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.salary)
    private let contractLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.contract,
        numberOfLines: 2)
    private let agentNameLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.agent)
    private let contactsLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.contacts)
    
    private let costValueLabel: DefaultTextLabel = {
        let label = DefaultTextLabel()
        label.textAlignment = .right
        return label
    }()
    private let salaryValueLabel: DefaultTextLabel = {
        let label = DefaultTextLabel()
        label.textAlignment = .right
        return label
    }()
    private let contractValueLabel: DefaultTextLabel = {
        let label = DefaultTextLabel()
        label.textAlignment = .right
        return label
    }()
    private let agentNameValueLabel: DefaultTextLabel = {
        let label = DefaultTextLabel()
        label.textAlignment = .right
        return label
    }()
    private let contactsValueLabel: DefaultTextLabel = {
        let label = DefaultTextLabel()
        label.textAlignment = .right
        return label
    }()
    
    private let testResultsLabel: CustomLabel = {
        let label = CustomLabel(
            font: Constants.Fonts.normal,
            text: Constants.Text.Titles.actualTest,
            color: .accent)
        label.textAlignment = .center
        return label
    }()
    
    private let testingDateLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.date)
    private let normativeLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.normative)
    private let scoreLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.score)
    
    private let testingDateValueLabel = DefaultTextLabel()
    
    private let runningFor15MLabel = DefaultTextLabel(
        text: Constants.Text.Titles.runningFor15M)
    private let runningFor30MLabel = DefaultTextLabel(
        text: Constants.Text.Titles.runningFor30M)
    private let longJumpLabel = DefaultTextLabel(
        text: Constants.Text.Titles.longJump)
    private let highJumpLabel = DefaultTextLabel(
        text: Constants.Text.Titles.highJump)
    
    private let descriptionLabel = CustomLabel(
        font: Constants.Fonts.description,
        text: Constants.Text.Descriptions.forGoalkeepers)
    
    private let runningFor15MResultLabel = DefaultTextLabel()
    private let runningFor30MResultLabel = DefaultTextLabel()
    private let longJumpResultLabel = DefaultTextLabel()
    private let highJumpResultLabel = DefaultTextLabel()
    
    private let runningFor15MScoreLabel = DefaultTextLabel()
    private let runningFor30MScoreLabel = DefaultTextLabel()
    private let longJumpScoreLabel = DefaultTextLabel()
    private let highJumpScoreLabel = DefaultTextLabel()
    
    private let summaryLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.Titles.summary)
    
    private let summaryValueLabel = DefaultTextLabel(numberOfLines: 0)
    
    private lazy var summaryStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [summaryLabel, summaryValueLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var testingContentView: UIView = {
        let view = UIView()
        view.addSubviews(
            testingDateLabel,
            testingDateValueLabel,
            normativeLabel,
            scoreLabel,
            runningFor15MLabel,
            runningFor15MResultLabel,
            runningFor15MScoreLabel,
            runningFor30MLabel,
            runningFor30MResultLabel,
            runningFor30MScoreLabel,
            longJumpLabel,
            longJumpResultLabel,
            longJumpScoreLabel,
            highJumpLabel,
            highJumpResultLabel,
            highJumpScoreLabel,
            descriptionLabel,
            summaryStackView
        )
        view.prepareForAutoLayout()
        return view
    }()
    
    private lazy var testingScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.layer.borderWidth = 1
        scrollView.layer.borderColor = UIColor.lightGray.cgColor
        scrollView.setupCornerRadius()
        scrollView.addSubview(testingContentView)
        scrollView.prepareForAutoLayout()
        return scrollView
    }()
    
    private let pageControl: DisabledPageControl = {
        let pageControl = DisabledPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 2
        return pageControl
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.deepGreen
        view.setupCornerRadius()
        view.setupBorder()
        view.addSubviews(
            titleLabel,
            costLabel,
            salaryLabel,
            contractLabel,
            agentNameLabel,
            contactsLabel,
            costValueLabel,
            salaryValueLabel,
            contractValueLabel,
            agentNameValueLabel,
            contactsValueLabel,
            testResultsLabel,
            testingScrollView,
            pageControl)
        view.prepareForAutoLayout()
        return view
    }()
    
    // MARK: Public Properties
    var viewModel: PlayerExtraCardViewModelProtocol? {
        didSet {
            costValueLabel.text = viewModel?.cost
            salaryValueLabel.text = viewModel?.salary
            contractValueLabel.text = viewModel?.contractDate
            agentNameValueLabel.text = viewModel?.agentName
            contactsValueLabel.text = viewModel?.contacts
            testingDateValueLabel.text = viewModel?.testingDate
            runningFor15MResultLabel.text = viewModel?.runningFor15MResult
            runningFor30MResultLabel.text = viewModel?.runningFor30MResult
            longJumpResultLabel.text = viewModel?.longJumpResult
            highJumpResultLabel.text = viewModel?.highJumpResult
            runningFor15MScoreLabel.text = viewModel?.runningFor15MScore
            runningFor30MScoreLabel.text = viewModel?.runningFor30MScore
            longJumpScoreLabel.text = viewModel?.longJumpScore
            highJumpScoreLabel.text = viewModel?.highJumpScore
            summaryValueLabel.text = viewModel?.summary
        }
    }

    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods
    private func setupUI() {
        addSubview(backgroundView)
        prepareForAutoLayout()
        setConstraints()
    }
}

// MARK: - Layout
private extension PlayerExtraCard {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16),
            
            titleLabel.topAnchor.constraint(
                equalTo: backgroundView.topAnchor,
                constant: 24),
            titleLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            titleLabel.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -24),
            
            costLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 16),
            costLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            costLabel.widthAnchor.constraint(equalTo: salaryLabel.widthAnchor),
            
            salaryLabel.topAnchor.constraint(
                equalTo: costLabel.bottomAnchor,
                constant: 10),
            salaryLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            salaryLabel.widthAnchor.constraint(equalToConstant: 170),
            
            contractLabel.topAnchor.constraint(
                equalTo: salaryLabel.bottomAnchor,
                constant: 10),
            contractLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            contractLabel.widthAnchor.constraint(
                equalTo: salaryLabel.widthAnchor),
            
            agentNameLabel.topAnchor.constraint(
                equalTo: contractLabel.bottomAnchor,
                constant: 10),
            agentNameLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            
            contactsLabel.topAnchor.constraint(
                equalTo: agentNameLabel.bottomAnchor,
                constant: 10),
            contactsLabel.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            contactsLabel.widthAnchor.constraint(equalToConstant: 120),
            
            costValueLabel.leadingAnchor.constraint(
                equalTo: salaryValueLabel.leadingAnchor),
            costValueLabel.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -24),
            costValueLabel.centerYAnchor.constraint(
                equalTo: costLabel.centerYAnchor,
                constant: -2),
            
            salaryValueLabel.leadingAnchor.constraint(
                equalTo: salaryLabel.trailingAnchor),
            salaryValueLabel.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -24),
            salaryValueLabel.centerYAnchor.constraint(
                equalTo: salaryLabel.centerYAnchor,
                constant: -2),
            
            contractValueLabel.leadingAnchor.constraint(
                equalTo: salaryValueLabel.leadingAnchor),
            contractValueLabel.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -24),
            contractValueLabel.centerYAnchor.constraint(
                equalTo: contractLabel.centerYAnchor,
                constant: -1),
            
            agentNameValueLabel.leadingAnchor.constraint(
                equalTo: contactsValueLabel.leadingAnchor),
            agentNameValueLabel.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -24),
            agentNameValueLabel.centerYAnchor.constraint(
                equalTo: agentNameLabel.centerYAnchor,
                constant: -2),
            
            contactsValueLabel.leadingAnchor.constraint(
                equalTo: contactsLabel.trailingAnchor),
            contactsValueLabel.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -24),
            contactsValueLabel.centerYAnchor.constraint(
                equalTo: contactsLabel.centerYAnchor,
                constant: -2),
            
            testResultsLabel.topAnchor.constraint(
                equalTo: contactsLabel.bottomAnchor,
                constant: 24),
            testResultsLabel.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor),
            
            testingScrollView.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 18),
            testingScrollView.topAnchor.constraint(
                equalTo: testResultsLabel.bottomAnchor,
                constant: 8),
            testingScrollView.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -18),
            testingScrollView.bottomAnchor.constraint(
                equalTo: pageControl.topAnchor,
                constant: -16),
            
            testingContentView.topAnchor.constraint(
                equalTo: testingScrollView.topAnchor,
                constant: 8),
            testingContentView.leadingAnchor.constraint(
                equalTo: testingScrollView.leadingAnchor,
                constant: 6),
            testingContentView.bottomAnchor.constraint(
                equalTo: testingScrollView.bottomAnchor,
                constant: -8),
            testingContentView.trailingAnchor.constraint(
                equalTo: testingScrollView.trailingAnchor,
                constant: -6),
            testingContentView.widthAnchor.constraint(
                equalTo: testingScrollView.widthAnchor,
                constant: -12),
            
            testingDateLabel.topAnchor.constraint(
                equalTo: testingContentView.topAnchor),
            testingDateLabel.leadingAnchor.constraint(
                equalTo: testingContentView.leadingAnchor),
            
            testingDateValueLabel.leadingAnchor.constraint(
                equalTo: testingDateLabel.trailingAnchor,
                constant: 12),
            testingDateValueLabel.centerYAnchor.constraint(
                equalTo: testingDateLabel.centerYAnchor,
                constant: -1),
            
            normativeLabel.topAnchor.constraint(
                equalTo: testingDateLabel.bottomAnchor,
                constant: 12),
            normativeLabel.leadingAnchor.constraint(
                equalTo: testingContentView.leadingAnchor),
            
            scoreLabel.topAnchor.constraint(
                equalTo: normativeLabel.topAnchor),
            scoreLabel.trailingAnchor.constraint(
                equalTo: testingContentView.trailingAnchor),
            
            runningFor15MLabel.topAnchor.constraint(
                equalTo: normativeLabel.bottomAnchor,
                constant: 8),
            runningFor15MLabel.leadingAnchor.constraint(
                equalTo: testingContentView.leadingAnchor),
            
            runningFor30MLabel.topAnchor.constraint(
                equalTo: runningFor15MLabel.bottomAnchor,
                constant: 8),
            runningFor30MLabel.leadingAnchor.constraint(
                equalTo: testingContentView.leadingAnchor),
            
            longJumpLabel.topAnchor.constraint(
                equalTo: runningFor30MLabel.bottomAnchor,
                constant: 8),
            longJumpLabel.leadingAnchor.constraint(
                equalTo: testingContentView.leadingAnchor),
            
            highJumpLabel.topAnchor.constraint(
                equalTo: longJumpLabel.bottomAnchor,
                constant: 8),
            highJumpLabel.leadingAnchor.constraint(
                equalTo: testingContentView.leadingAnchor),
            highJumpLabel.widthAnchor.constraint(equalToConstant: 135),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: highJumpLabel.bottomAnchor,
                constant: -2),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: testingContentView.leadingAnchor),
            
            runningFor15MResultLabel.leadingAnchor.constraint(
                equalTo: highJumpResultLabel.leadingAnchor),
            runningFor15MResultLabel.centerYAnchor.constraint(
                equalTo: runningFor15MLabel.centerYAnchor),
            
            runningFor30MResultLabel.leadingAnchor.constraint(
                equalTo: highJumpResultLabel.leadingAnchor),
            runningFor30MResultLabel.centerYAnchor.constraint(
                equalTo: runningFor30MLabel.centerYAnchor),
            
            longJumpResultLabel.leadingAnchor.constraint(
                equalTo: highJumpResultLabel.leadingAnchor),
            longJumpResultLabel.centerYAnchor.constraint(
                equalTo: longJumpLabel.centerYAnchor),
            
            highJumpResultLabel.leadingAnchor.constraint(
                equalTo: highJumpLabel.trailingAnchor,
                constant: 16),
            highJumpResultLabel.centerYAnchor.constraint(
                equalTo: highJumpLabel.centerYAnchor),
            
            runningFor15MScoreLabel.centerXAnchor.constraint(
                equalTo: scoreLabel.centerXAnchor),
            runningFor15MScoreLabel.centerYAnchor.constraint(
                equalTo: runningFor15MLabel.centerYAnchor),
            
            runningFor30MScoreLabel.centerXAnchor.constraint(
                equalTo: scoreLabel.centerXAnchor),
            runningFor30MScoreLabel.centerYAnchor.constraint(
                equalTo: runningFor30MLabel.centerYAnchor),
            
            longJumpScoreLabel.centerXAnchor.constraint(
                equalTo: scoreLabel.centerXAnchor),
            longJumpScoreLabel.centerYAnchor.constraint(
                equalTo: longJumpLabel.centerYAnchor),
            
            highJumpScoreLabel.centerXAnchor.constraint(
                equalTo: scoreLabel.centerXAnchor),
            highJumpScoreLabel.centerYAnchor.constraint(
                equalTo: highJumpLabel.centerYAnchor),
            
            summaryStackView.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: 12),
            summaryStackView.leadingAnchor.constraint(
                equalTo: testingContentView.leadingAnchor),
            summaryStackView.bottomAnchor.constraint(
                equalTo: testingContentView.bottomAnchor),
            summaryStackView.trailingAnchor.constraint(
                equalTo: testingContentView.trailingAnchor,
                constant: -8),
            
            pageControl.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor),
            pageControl.bottomAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: -12)
        ])
    }
}
