//
//  PrimaryTextFieldView.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 05.03.2024.
//

import UIKit

enum TextFieldType {
    case key, name, phone
}

final class PrimaryTextFieldView: UIView {
    
    // MARK: Private Properties
    private let _placeholder: String
    private let textFieldType: TextFieldType
    
    // MARK: Views
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = Constants.Fonts.text
        textField.textColor = .black
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
        label.textColor = .black
        label.font = Constants.Fonts.secondary
        return label
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [floatingLabel, textField])
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: Initialize
    init(placeholder: String, type: TextFieldType) {
        _placeholder = placeholder
        textFieldType = type
        super.init(frame: .zero)
        textField.setupAttributesOfPlaceholder(placeholder)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setCommonShadow()
        if let text = textField.text, !text.isEmpty {
            addFloatingLabel()
        }
    }
    
    // MARK: Private Methods
    private func setupUI() {
        backgroundColor = .white
        setCommonCornerRadius()
        addSubview(containerStackView)
        prepareForAutoLayout()
        setConstraints()
    }
    
    @objc private func addFloatingLabel() {
        floatingLabel.text = _placeholder
        floatingLabel.isHidden = false
        textField.placeholder = ""
    }
    
    @objc private func removeFloatingLabel() {
        if textField.text == "" {
            floatingLabel.isHidden = true
            textField.placeholder = _placeholder
        }
    }
    
    // MARK: Public Methods
    func set(tag: Int) {
        textField.tag = tag
    }
    
    func set(text: String?) {
        textField.text = text
    }
    
    func getInputText() -> String {
        guard let text = textField.text else { return "" }
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
