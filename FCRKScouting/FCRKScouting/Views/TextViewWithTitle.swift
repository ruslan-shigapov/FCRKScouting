//
//  TextViewWithTitle.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 10.04.2024.
//

import UIKit

final class TextViewWithTitle: UIView {
    
    // MARK: Views
    private let titleLabel = CustomLabel(
        font: Constants.Fonts.normal)

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = Constants.Fonts.text
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.spellCheckingType = .no
        textView.autocorrectionType = .no
        textView.textContainerInset = UIEdgeInsets(
            top: 10,
            left: 5,
            bottom: 10,
            right: 5)
        textView.setCommonCornerRadius()
        return textView
    }()

    // MARK: Initialize
    init(_ title: String) {
        titleLabel.text = title
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
        setConstraints()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        addSubviews(titleLabel, textView)
        prepareForAutoLayout()
    }
    
    // MARK: Public Methods    
    func set(text: String?) {
        textView.text = text
    }
    
    func getInputText() -> String {
        guard let text = textView.text else { return "" }
        return text
    }
}

// MARK: - Layout
private extension TextViewWithTitle {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            textView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 8),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -20),
            textView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -20)
        ])
    }
}
