//
//  TextViewWithTitle.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 10.04.2024.
//

import UIKit

final class TextViewWithTitle: UIView {
    
    // MARK: Private Properties
    private let title: String
    
    // MARK: Views
    private lazy var titleLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: title)

    private lazy var roundedTextView: UITextView = {
        let textView = UITextView()
        textView.font = Constants.Fonts.text
        textView.textContainerInset = UIEdgeInsets(
            top: 10,
            left: 5,
            bottom: 10,
            right: 5)
        textView.setCustomCornerRadius()
        return textView
    }()

    // MARK: Initialize
    init(_ title: String) {
        self.title = title
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        roundedTextView.setCustomShadow()
        setConstraints()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        addSubviews(titleLabel, roundedTextView)
        prepareForAutoLayout()
    }
    
    // MARK: Public Methods
    func getInputText() -> String {
        guard let text = roundedTextView.text else { return "" }
        return text
    }
}

// MARK: - Layout
private extension TextViewWithTitle {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            roundedTextView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 8),
            roundedTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            roundedTextView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -20),
            roundedTextView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -20),
        ])
    }
}
