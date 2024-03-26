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
    
    // MARK: Properties
    private let textFieldType: TextFieldType
    private let _placeholder: String
    
    // MARK: Views
    private lazy var roundedTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16, weight: .light)
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
        label.textColor = .placeholderText
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.isHidden = true
        return label
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [floatingLabel, roundedTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: Initialize
    init(placeholder: String, type: TextFieldType, tag: Int = 1) {
        self.textFieldType = type
        self._placeholder = placeholder
        super.init(frame: .zero)
        
        roundedTextField.tag = tag
        setupTextField(placeholder: placeholder)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func setupTextField(placeholder: String) {
        roundedTextField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .light)])
    }
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(containerStackView)
        layer.cornerRadius = 12
        setupShadow()
        setConstraints()
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 10, height: -10)
    }
    
    @objc private func addFloatingLabel() {
        if roundedTextField.text == "" {
            floatingLabel.text = _placeholder
            floatingLabel.isHidden = false
            roundedTextField.placeholder = ""
        }
    }
    
    @objc private func removeFloatingLabel() {
        if roundedTextField.text == "" {
            floatingLabel.isHidden = true
            roundedTextField.placeholder = _placeholder
        }
    }
    
    // MARK: Public Methods
    func setDelegate(_ delegate: UIViewController) {
        roundedTextField.delegate = delegate as? any UITextFieldDelegate
    }
    
    func getInputText() -> String? {
        roundedTextField.text
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
