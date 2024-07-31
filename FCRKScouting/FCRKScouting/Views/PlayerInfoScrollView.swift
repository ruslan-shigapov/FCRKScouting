//
//  PlayerInfoScrollView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 04.07.2024.
//

import UIKit

final class PlayerInfoScrollView: UIScrollView {
    
    // MARK: Views
    private let generalInfoLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.TextViewTitles.generalInfo)
    private let techniqueLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.TextViewTitles.technique)
    private let tacticsLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.TextViewTitles.tactics)
    private let qualitiesLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.TextViewTitles.qualities)
    private let mentalLabel = CustomLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.TextViewTitles.mental)
    
    private let generalInfoValueLabel = DefaultTextLabel(numberOfLines: 0)
    private let techniqueValueLabel = DefaultTextLabel(numberOfLines: 0)
    private let tacticsValueLabel = DefaultTextLabel(numberOfLines: 0)
    private let qualitiesValueLabel = DefaultTextLabel(numberOfLines: 0)
    private let mentalValueLabel = DefaultTextLabel(numberOfLines: 0)
            
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                generalInfoLabel,
                generalInfoValueLabel,
                techniqueLabel,
                techniqueValueLabel,
                tacticsLabel,
                tacticsValueLabel,
                qualitiesLabel,
                qualitiesValueLabel,
                mentalLabel,
                mentalValueLabel
            ])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.addSubview(containerStackView)
        view.prepareForAutoLayout()
        return view
    }()

    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        setupCornerRadius()
        addSubviews(backgroundView)
        prepareForAutoLayout()
    }
    
    // MARK: Public Methods
    func configure(
        withGeneralInfoValue generalInfoValue: String?,
        techniqueValue: String?,
        tacticsValue: String?,
        qualitiesValue: String?,
        mentalValue: String?
    ) {
        generalInfoValueLabel.text = generalInfoValue
        techniqueValueLabel.text = techniqueValue
        tacticsValueLabel.text = tacticsValue
        qualitiesValueLabel.text = qualitiesValue
        mentalValueLabel.text = mentalValue
    }
}

// MARK: - Layout
private extension PlayerInfoScrollView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 8),
            backgroundView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 6),
            backgroundView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -8),
            backgroundView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -6),
            backgroundView.widthAnchor.constraint(
                equalTo: widthAnchor,
                constant: -12),
            
            containerStackView.topAnchor.constraint(
                equalTo: backgroundView.topAnchor),
            containerStackView.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor),
            containerStackView.bottomAnchor.constraint(
                equalTo: backgroundView.bottomAnchor),
            containerStackView.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -8)
        ])
    }
}
