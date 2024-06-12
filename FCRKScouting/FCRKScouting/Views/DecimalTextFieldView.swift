//
//  DecimalTextFieldView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 29.05.2024.
//

import UIKit

enum DecimalTextFieldType {
    case meters, time, weight
    
    var maxLength: Int {
        switch self {
        case .meters: 4
        case .time, .weight: 5
        }
    }
    var placeholder: String {
        switch self {
        case .meters: "0.00"
        case .time, .weight: "00.00"
        }
    }
}

final class DecimalTextFieldView: UIView {
    
    // MARK: Private Properties 
    private let textFieldType: DecimalTextFieldType
    private let unitTitle: String

    // MARK: Views
    private let roundedTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
        textField.font = Constants.Fonts.text
        textField.leftView = UIView(
            frame: CGRectMake(0, 0, 5, textField.frame.height))
        textField.leftViewMode = .always
        textField.setCustomCornerRadius()
        return textField
    }()
    
    private lazy var unitLabel = DefaultGrayLabel(text: unitTitle)
    
    // MARK: Initialize
    init(textFieldType: DecimalTextFieldType, unitTitle: String) {
        self.unitTitle = unitTitle
        self.textFieldType = textFieldType
        super.init(frame: .zero)
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
        roundedTextField.setCustomShadow()
    }
        
    // MARK: Private Methods
    private func setupUI() {
        roundedTextField.placeholder = textFieldType.placeholder
        addSubviews(roundedTextField, unitLabel)
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
extension DecimalTextFieldView: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let text = textField.text else { return true }
        if text.count == textFieldType.maxLength, !string.isEmpty {
            return false
        }
        if text.count == textFieldType.maxLength - 4, !string.isEmpty {
            textField.text = text + string + "."
            return false
        }
        if text.count == textFieldType.maxLength - 2, string.isEmpty {
            textField.text?.removeLast()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.count < textFieldType.maxLength, text.contains(".") {
            textField.text = text + String(
                repeating: "0",
                count: textFieldType.maxLength - text.count)
        }
        if text.count == 1, textFieldType.maxLength == 5 {
            textField.text = "0" + text + ".00"
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textField.moveCursorToEnd()
    }
}

// MARK: - Layout
extension DecimalTextFieldView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            roundedTextField.topAnchor.constraint(equalTo: topAnchor),
            roundedTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            roundedTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            roundedTextField.heightAnchor.constraint(equalToConstant: 30),
            roundedTextField.widthAnchor.constraint(equalToConstant: 55),
            
            unitLabel.leadingAnchor.constraint(
                equalTo: roundedTextField.trailingAnchor,
                constant: 6),
            unitLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            unitLabel.centerYAnchor.constraint(
                equalTo: roundedTextField.centerYAnchor,
                constant: -1)
        ])
    }
}
