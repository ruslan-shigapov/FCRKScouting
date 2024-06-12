//
//  PrimaryTextFieldView.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 05.03.2024.
//

import UIKit

enum TextFieldType {
    case name, key, phone
}

final class PrimaryTextFieldView: UIView {
    
    // MARK: Private Properties
    private let _placeholder: String
    private let textFieldType: TextFieldType
    
    // MARK: Views
    private lazy var customTextField: UITextField = {
        let textField = UITextField()
        textField.font = Constants.Fonts.text
        textField.clearButtonMode = .whileEditing
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.autocapitalizationType = .words
        textField.delegate = self
        if textFieldType != .name {
            textField.keyboardType = .numberPad
        }
        if textFieldType == .key {
            textField.isSecureTextEntry = true
        }
        textField.addTarget(
            self,
            action: #selector(addFloatingLabel),
            for: .editingDidBegin)
        textField.addTarget(
            self,
            action: #selector(removeFloatingLabel),
            for: .editingDidEnd)
        return textField
    }()
    
    private let floatingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accent
        label.font = Constants.Fonts.description
        return label
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [floatingLabel, customTextField])
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: Initialize
    init(placeholder: String, type: TextFieldType) {
        self._placeholder = placeholder
        self.textFieldType = type
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setCustomShadow()
        if let text = customTextField.text, !text.isEmpty {
            addFloatingLabel()
        }
    }
    
    // MARK: Private Methods
    private func setupTextField(placeholder: String) {
        customTextField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.font: Constants.Fonts.text])
    }
    
    private func setupUI() {
        backgroundColor = .white
        setCustomCornerRadius()
        addSubview(containerStackView)
        prepareForAutoLayout()
        setConstraints()
    }
    
    @objc private func addFloatingLabel() {
        floatingLabel.text = _placeholder
        floatingLabel.isHidden = false
        customTextField.placeholder = ""
    }
    
    @objc private func removeFloatingLabel() {
        if customTextField.text == "" {
            floatingLabel.isHidden = true
            customTextField.placeholder = _placeholder
        }
    }
    
    // MARK: Public Methods
    func set(tag: Int) {
        customTextField.tag = tag
    }
    
    func set(text: String?) {
        customTextField.text = text
    }
    
    func getInputText() -> String {
        guard let text = customTextField.text else { return "" }
        return text
    }
}

// MARK: - Text Field Delegate
extension PrimaryTextFieldView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.focusNextResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textFieldType != .name {
            textField.moveCursorToEnd()
        }
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let text = textField.text else { return true }
        if textFieldType == .key {
            let length = text.count + string.count - range.length
            if length > 6 { return false }
        }
        if textFieldType == .phone {
            let newText = (text as NSString).replacingCharacters(
                in: range,
                with: string)
            let digitsOnly = newText.filter { $0.isWholeNumber }
            if digitsOnly.count > 11 {
                return false
            }
            if newText == "+" {
                textField.text = ""
                return false
            }
            textField.text = digitsOnly.formatToPhoneNumber()
            return false
        }
        return true
    }
}

// MARK: - Layout
extension PrimaryTextFieldView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48),
            
            containerStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16),
            containerStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16)
        ])
    }
}
