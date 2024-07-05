//
//  ScoreTextFieldView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 19.06.2024.
//

import UIKit

final class ScoreTextFieldView: UIView {

    // MARK: Views
    private let titleLabel = DefaultTextLabel(text: Constants.Text.Titles.score)

    private let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.keyboardType = .numberPad
        textField.font = Constants.Fonts.text
        textField.rightView = UIView(
            frame: CGRectMake(0, 0, 10, textField.frame.height))
        textField.rightViewMode = .always
        textField.textAlignment = .right
        textField.setupCornerRadius()
        return textField
    }()

    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        textField.delegate = self
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        textField.setupShadow()
    }
        
    // MARK: Private Methods
    private func setupUI() {
        textField.placeholder = "0"
        if let placeholder = textField.placeholder {
            textField.setupAttributes(ofPlaceholder: placeholder)
        }
        addSubviews(titleLabel, textField)
        setConstraints()
        prepareForAutoLayout()
    }
    
    // MARK: Public Methods
    func set(text: String?) {
        textField.text = text
    }
    
    func getInputText() -> String? {
        textField.text
    }
}

// MARK: - Text Field Delegate
extension ScoreTextFieldView: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let text = textField.text else { return true }
        if text.count == 1, !string.isEmpty { return false }
        return true
    }
}

// MARK: - Layout
extension ScoreTextFieldView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerYAnchor.constraint(
                equalTo: textField.centerYAnchor,
                constant: -1),
            
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(
                equalTo: titleLabel.trailingAnchor, 
                constant: 6),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 30),
            textField.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
