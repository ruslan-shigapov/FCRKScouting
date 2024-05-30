//
//  DecimalTextFieldView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 29.05.2024.
//

import UIKit

final class DecimalTextFieldView: UIView {
    
    // MARK: Private Properties 
    private let unitTitle: String

    // MARK: Views
    private let roundedTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
        textField.leftView = UIView(
            frame: CGRectMake(0, 0, 5, textField.frame.height))
        textField.leftViewMode = .always
        textField.font = Constants.Fonts.text
        textField.setCustomCornerRadius()
        return textField
    }()
    
    private lazy var unitLabel = DefaultLabel(text: unitTitle)
    
    // MARK: Initialize
    init(unitTitle: String) {
        self.unitTitle = unitTitle
        super.init(frame: .zero)
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
        addSubviews(roundedTextField, unitLabel)
        setConstraints()
        prepareForAutoLayout()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            roundedTextField.topAnchor.constraint(equalTo: topAnchor),
            roundedTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            roundedTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            roundedTextField.heightAnchor.constraint(equalToConstant: 30),
            roundedTextField.widthAnchor.constraint(equalToConstant: 54),
            
            unitLabel.leadingAnchor.constraint(
                equalTo: roundedTextField.trailingAnchor,
                constant: 6),
            unitLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            unitLabel.centerYAnchor.constraint(
                equalTo: roundedTextField.centerYAnchor,
                constant: -1)
        ])
    }
    
    // MARK: Public Methods
    func set(delegate: UITextFieldDelegate) {
        roundedTextField.delegate = delegate 
    }
    
    func set(tag: Int) {
        roundedTextField.tag = tag
    }
    
    func set(text: String?) {
        guard let text else { return }
        roundedTextField.text = text
    }
    
    func getInputText() -> String {
        guard let text = roundedTextField.text else { return "" }
        return text
    }
}
