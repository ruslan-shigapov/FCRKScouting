//
//  ScoreTextFieldView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 19.06.2024.
//

import UIKit

final class ScoreTextFieldView: UIView {

    // MARK: Views
    private lazy var titleLabel = DefaultTextLabel(text: Constants.Text.score)

    private let roundedTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
        textField.font = Constants.Fonts.text
        textField.rightView = UIView(
            frame: CGRectMake(0, 0, 10, textField.frame.height))
        textField.rightViewMode = .always
        textField.textAlignment = .right
        textField.setCommonCornerRadius()
        return textField
    }()

    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        roundedTextField.delegate = self
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        roundedTextField.setCommonShadow()
    }
        
    // MARK: Private Methods
    private func setupUI() {
        roundedTextField.placeholder = "0"
        addSubviews(titleLabel, roundedTextField)
        setConstraints()
        prepareForAutoLayout()
    }
    
    // MARK: Public Methods
    func set(text: String?) {
        roundedTextField.text = text
    }
    
    func getInputText() -> String? {
        roundedTextField.text
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
                equalTo: roundedTextField.centerYAnchor,
                constant: -1),
            
            roundedTextField.topAnchor.constraint(equalTo: topAnchor),
            roundedTextField.leadingAnchor.constraint(
                equalTo: titleLabel.trailingAnchor, 
                constant: 6),
            roundedTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            roundedTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            roundedTextField.heightAnchor.constraint(equalToConstant: 30),
            roundedTextField.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
