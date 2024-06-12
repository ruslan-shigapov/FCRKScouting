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
            frame: CGRectMake(0, 0, 5, textField.frame.height))
        textField.rightViewMode = .always
        textField.setCustomCornerRadius()
        return textField
    }()
    
    private let currencySegmentedControl = CustomSegmentedControl(
        items: ["\u{20BD}", "$"])
    
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
        roundedTextField.setCustomShadow()
        currencySegmentedControl.setCustomShadow()
    }
    
    // MARK: Private Methods 
    private func setupUI() {
        roundedTextField.placeholder = "0"
        addSubviews(roundedTextField, currencySegmentedControl)
        setConstraints()
        prepareForAutoLayout()
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
            roundedTextField.heightAnchor.constraint(equalToConstant: 30),
            roundedTextField.widthAnchor.constraint(equalToConstant: 120),
            
            currencySegmentedControl.leadingAnchor.constraint(
                equalTo: roundedTextField.trailingAnchor,
                constant: 10),
            currencySegmentedControl.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            currencySegmentedControl.centerYAnchor.constraint(
                equalTo: roundedTextField.centerYAnchor,
                constant: -1)
        ])
    }
}
