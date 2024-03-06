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
        textField.autocorrectionType = .no
        switch textFieldType {
        case .name: textField.keyboardType = .alphabet
        case .key: textField.keyboardType = .numberPad
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
    init(placeholder: String, type: TextFieldType) {
        self.textFieldType = type
        self._placeholder = placeholder
        super.init(frame: .zero)
        
        roundedTextField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .font: UIFont.systemFont(ofSize: 16, weight: .light)
            ])
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    private func setupUI() {
        backgroundColor = .white
        addSubview(containerStackView)
        layer.cornerRadius = 12
        setConstraints()
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
}

// MARK: - Layout
private extension RoundedTextFieldView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 300),
            heightAnchor.constraint(equalToConstant: 52),
            
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
