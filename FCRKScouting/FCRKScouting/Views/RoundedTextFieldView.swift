//
//  RoundedTextFieldView.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 05.03.2024.
//

import UIKit

enum TextFieldType {
    case name
    case key
}

final class RoundedTextFieldView: UIView {
    
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
        if textFieldType == .key {
            textField.keyboardType = .numberPad
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
        label.isHidden = true
        return label
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [floatingLabel, customTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: Initialize
    init(placeholder: String, type: TextFieldType, tag: Int = 1) {
        self._placeholder = placeholder
        self.textFieldType = type
        super.init(frame: .zero)
        customTextField.tag = tag
        setupTextField(placeholder: placeholder)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        setCustomShadow()
        addSubview(containerStackView)
        setConstraints()
    }
    
    @objc private func addFloatingLabel() {
        if customTextField.text == "" {
            floatingLabel.text = _placeholder
            floatingLabel.isHidden = false
            customTextField.placeholder = ""
        }
    }
    
    @objc private func removeFloatingLabel() {
        if customTextField.text == "" {
            floatingLabel.isHidden = true
            customTextField.placeholder = _placeholder
        }
    }
    
    // MARK: Public Methods
    func set(delegate: UIViewController) {
        customTextField.delegate = delegate as? any UITextFieldDelegate
    }
    
    func getInputText() -> String {
        guard let text = customTextField.text else { return "" }
        return text
    }
}

// MARK: - Layout
private extension RoundedTextFieldView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 300),
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
