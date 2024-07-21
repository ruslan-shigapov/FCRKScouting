//
//  NumeralTextFieldView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 19.06.2024.
//

import UIKit

enum NumeralTextFieldType {
    case score, age
}

final class NumeralTextFieldView: UIView {
    
    // MARK: Private Properties 
    private let type: NumeralTextFieldType
    
    private var widthConstant: CGFloat {
        switch type {
        case .score: 30
        case .age: 50
        }
    }
    
    // MARK: Views
    private let titleLabel = DefaultTextLabel()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.keyboardType = .numberPad
        textField.font = Constants.Fonts.text
        textField.rightView = UIView(
            frame: CGRectMake(0, 0, 10, textField.frame.height))
        textField.rightViewMode = .always
        textField.textAlignment = .right
        textField.setupCornerRadius()
        return textField
    }()

    // MARK: Initialize
    init(type: NumeralTextFieldType) {
        self.type = type
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
        textField.setupShadow()
    }
        
    // MARK: Private Methods
    private func setupUI() {
        if type == .score {
            titleLabel.text = Constants.Text.Titles.score
        }
        textField.placeholder = "0"
        if let placeholder = textField.placeholder {
            textField.setupAttributes(ofPlaceholder: placeholder)
        }
        addSubviews(titleLabel, textField)
        setConstraints()
        prepareForAutoLayout()
    }
    
    // MARK: Public Methods
    func set(text: String?) {
        textField.text = text
    }
    
    func getInputText() -> String? {
        textField.text
    }
}

// MARK: - Text Field Delegate
extension NumeralTextFieldView: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let text = textField.text else { return true }
        var maxDigits: Int
        switch type {
        case .score: maxDigits = 1
        case .age: maxDigits = 2
        }
        if text.count == maxDigits, !string.isEmpty { return false }
        return true
    }
}

// MARK: - Layout
extension NumeralTextFieldView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerYAnchor.constraint(
                equalTo: textField.centerYAnchor,
                constant: -1),
            
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(
                equalTo: titleLabel.trailingAnchor, 
                constant: 6),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 30),
            textField.widthAnchor.constraint(equalToConstant: widthConstant)
        ])
    }
}
