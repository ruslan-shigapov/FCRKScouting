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
        case .meters, .time: 4
        case .weight: 5
        }
    }
    var placeholder: String {
        switch self {
        case .meters, .time: "0.00"
        case .weight: "00.00"
        }
    }
    var unit: String {
        switch self {
        case .meters: "м"
        case .time: "сек"
        case .weight: "кг"
        }
    }
}

final class DecimalTextFieldView: UIView {
    
    // MARK: Private Properties 
    private let textFieldType: DecimalTextFieldType

    // MARK: Views
    private let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.keyboardType = .numberPad
        textField.font = Constants.Fonts.text
        textField.leftView = UIView(
            frame: CGRectMake(0, 0, 6, textField.frame.height))
        textField.leftViewMode = .always
        textField.setCommonCornerRadius()
        return textField
    }()
    
    private lazy var unitLabel = DefaultTextLabel(text: textFieldType.unit)
    
    // MARK: Initialize
    init(type: DecimalTextFieldType) {
        textFieldType = type
        super.init(frame: .zero)
        textField.delegate = self
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        textField.setCommonShadow()
    }
        
    // MARK: Private Methods
    private func setupUI() {
        textField.placeholder = textFieldType.placeholder
        if let placeholder = textField.placeholder {
            textField.setupAttributesOfPlaceholder(placeholder)
        }
        addSubviews(textField, unitLabel)
        setConstraints()
        prepareForAutoLayout()
    }
    
    // MARK: Public Methods
    func set(text: String?) {
        textField.text = text
    }
    
    func getInputText() -> String {
        guard let text = textField.text else { return "" }
        return text
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
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: 30),
            textField.widthAnchor.constraint(equalToConstant: 55),
            
            unitLabel.leadingAnchor.constraint(
                equalTo: textField.trailingAnchor,
                constant: 6),
            unitLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            unitLabel.centerYAnchor.constraint(
                equalTo: textField.centerYAnchor,
                constant: -1)
        ])
    }
}
