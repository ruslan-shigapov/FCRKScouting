//
//  TextViewWithTitle.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 10.04.2024.
//

import UIKit

final class TextViewWithTitle: UIView {
    
    // MARK: Private Properties
    private let titleView: UIView

    // MARK: Views
    private lazy var roundedTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.font = Constants.Fonts.text
        textView.autocorrectionType = .no
        textView.textContainerInset = UIEdgeInsets(
            top: 10,
            left: 5,
            bottom: 10,
            right: 5)
        textView.setCustomCornerRadius()
        return textView
    }()

    // MARK: Initialize
    init(view: UIView) {
        self.titleView = view
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func setupUI() {
        setCustomShadow()
        addSubviews(titleView, roundedTextView)
        prepareForAutoLayout()
        setConstraints()
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
            titleView.topAnchor.constraint(equalTo: topAnchor),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            roundedTextView.topAnchor.constraint(
                equalTo: titleView.bottomAnchor,
                constant: 8),
            roundedTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            roundedTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            roundedTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            roundedTextView.heightAnchor.constraint(equalToConstant: 96)
        ])
    }
}
