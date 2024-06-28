//
//  PriceTextFieldView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 06.06.2024.
//

import UIKit

final class PriceTextFieldView: UIView {
    
    // MARK: Views
    private let roundedTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
        textField.font = Constants.Fonts.text
        textField.textAlignment = .right
        textField.rightView = UIView(
            frame: CGRectMake(0, 0, 10, textField.frame.height))
        textField.rightViewMode = .always
        textField.setCommonCornerRadius()
        return textField
    }()
    
    private let currencyLabel = DefaultTextLabel(text: "\u{20BD}")
    
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
        addSubviews(roundedTextField, currencyLabel)
        setConstraints()
        prepareForAutoLayout()
    }
    
    // MARK: Public Methods
    func set(text: String?) {
        roundedTextField.text = text
    }
    
    func getInputText() -> String {
        guard let text = roundedTextField.text else { return "" }
        return text
    }
}

// MARK: - Text Field Delegate
extension PriceTextFieldView: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let text = textField.text else { return true }
        if text.count == 10, !string.isEmpty {
            return false
        }
        let newText = (text as NSString).replacingCharacters(
            in: range,
            with: string)
        let nonSpaceText = newText.replacingOccurrences(of: " ", with: "")
        let spacedCharacters = Array(nonSpaceText).enumerated().map {
            (nonSpaceText.count - $0) % 3 == 0 ? [" ", $1] : [$1]
        }
        textField.text = spacedCharacters.map { String($0) }.joined()
        return false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textField.moveCursorToEnd()
    }
}

// MARK: - Layout
extension PriceTextFieldView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            roundedTextField.topAnchor.constraint(equalTo: topAnchor),
            roundedTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            roundedTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            roundedTextField.heightAnchor.constraint(equalToConstant: 35),
            roundedTextField.widthAnchor.constraint(equalToConstant: 120),
            
            currencyLabel.leadingAnchor.constraint(
                equalTo: roundedTextField.trailingAnchor,
                constant: 6),
            currencyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            currencyLabel.centerYAnchor.constraint(
                equalTo: roundedTextField.centerYAnchor)
        ])
    }
}
