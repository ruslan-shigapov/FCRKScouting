//
//  DatePickerView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 07.06.2024.
//

import UIKit

enum DatePickerType {
    case birth, contract, standard
    
    var placeholder: String {
        switch self {
        case .birth, .standard: Constants.Text.notSpecified1
        case .contract:Constants.Text.notSpecified2
        }
    }
}

final class DatePickerView: UIView {
    
    // MARK: Private Properties
    private let datePickerType: DatePickerType
    
    // MARK: Views
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.isEnabled = false
        switch datePickerType {
        case .birth: datePicker.maximumDate = Date()
        case .contract: datePicker.minimumDate = Date()
        case .standard: 
            datePicker.maximumDate = Date()
            datePicker.isEnabled = true
        }
        return datePicker
    }()
    
    private lazy var placeholderLabel: CustomLabel = {
        let label = CustomLabel(
            font: Constants.Fonts.text,
            text: datePickerType.placeholder)
        label.textColor = .black
        return label
    }()

    // MARK: Initialize
    init(type: DatePickerType) {
        datePickerType = type
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
        setupShadow()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        backgroundColor = .lightGray
        placeholderLabel.isHidden = datePicker.isEnabled
        datePicker.isHidden = !placeholderLabel.isHidden
        addSubviews(datePicker, placeholderLabel)
        prepareForAutoLayout()
        setConstraints()
        setupCornerRadius()
    }
    
    private func toggleSubviewInFront() {
        datePicker.isHidden.toggle()
        placeholderLabel.isHidden.toggle()
        datePicker.isEnabled
        ? bringSubviewToFront(placeholderLabel)
        : bringSubviewToFront(datePicker)
    }
    
    // MARK: Public Methods
    func set(date: Date) {
        datePicker.date = date
    }
    
    func getDate() -> Date {
        datePicker.date
    }
    
    func toggleDatePickerEnabled() {
        datePicker.isEnabled.toggle()
        toggleSubviewInFront()
    }
}

// MARK: - Layout
private extension DatePickerView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 35),
            widthAnchor.constraint(equalTo: datePicker.widthAnchor),
            
            placeholderLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
