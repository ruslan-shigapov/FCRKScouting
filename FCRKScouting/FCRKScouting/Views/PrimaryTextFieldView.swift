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
    private lazy var clearButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(Constants.Images.ButtonImages.clear, for: .normal)
        $0.tintColor = .lightGray
        $0.isHidden = true
        $0.addTarget(
            self,
            action: #selector(clearButtonTapped),
            for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var customTextField: UITextField = {
        $0.font = Constants.Fonts.text
        $0.textColor = .black
        $0.rightView = clearButton
        $0.rightViewMode = .always
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.autocapitalizationType = .words
        $0.delegate = self
        if textFieldType != .name {
            $0.keyboardType = .numberPad
        }
        if textFieldType == .key {
            $0.isSecureTextEntry = true
        }
        $0.addTarget(
            self,
            action: #selector(addFloatingLabel),
            for: .editingDidBegin)
        $0.addTarget(
            self,
            action: #selector(removeFloatingLabel),
            for: .editingDidEnd)
        return $0
    }(UITextField())
    
    private let floatingLabel = CustomLabel(
        font: Constants.Fonts.secondary,
        color: .black)
    
    private lazy var containerStackView: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView(arrangedSubviews: [floatingLabel, customTextField]))
    
    // MARK: Initialize
    init(placeholder: String, type: TextFieldType) {
        _placeholder = placeholder
        textFieldType = type
        super.init(frame: .zero)
        customTextField.setupAttributes(ofPlaceholder: placeholder)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
        if let text = customTextField.text, !text.isEmpty {
            addFloatingLabel()
        }
    }
    
    // MARK: Private Methods
    private func setupUI() {
        backgroundColor = .white
        setupCornerRadius()
        addSubview(containerStackView)
        prepareForAutoLayout()
        setConstraints()
    }
    
    // MARK: Actions
    @objc private func clearButtonTapped() {
        customTextField.text = ""
        removeFloatingLabel()
        clearButton.isHidden = true
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
        guard let text = textField.text else { return }
        clearButton.isHidden = text.isEmpty
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
            
            clearButton.widthAnchor.constraint(equalToConstant: 30),
            
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
