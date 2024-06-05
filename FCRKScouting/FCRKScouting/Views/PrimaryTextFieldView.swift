//
//  PrimaryTextFieldView.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 05.03.2024.
//

import UIKit

enum TextFieldType {
    case name, key
}

final class PrimaryTextFieldView: UIView, UITextFieldDelegate {
    
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.focusNextResponder()
        return true
    }
    
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

// MARK: - Layout
private extension PrimaryTextFieldView {
    
    func setConstraints() {
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
