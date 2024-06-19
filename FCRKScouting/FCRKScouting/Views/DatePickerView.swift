//
//  DatePickerView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 07.06.2024.
//

import UIKit

enum DatePickerType {
    case birth, contract, standard
}

final class DatePickerView: UIView {
    
    // MARK: Private Properties
    private let type: DatePickerType
    
    // MARK: Views
    private lazy var customDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        switch type {
        case .birth: datePicker.maximumDate = Date()
        case .contract: 
            datePicker.minimumDate = Date()
            datePicker.isEnabled = false
        case .standard: break
        }
        return datePicker
    }()

    // MARK: Initialize
    init(type: DatePickerType) {
        self.type = type
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
        setCommonShadow()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        setBackgroundColor()
        addSubview(customDatePicker)
        prepareForAutoLayout()
        setConstraints()
        setCommonCornerRadius()
    }
    
    private func setBackgroundColor() {
        backgroundColor = customDatePicker.isEnabled ? .white : .lightGray
    }
    
    // MARK: Public Methods
    func set(date: Date) {
        customDatePicker.date = date
    }
    
    func getDate() -> Date {
        customDatePicker.date
    }
    
    func toggleEnabled() {
        customDatePicker.isEnabled.toggle()
        setBackgroundColor()
    }
}

// MARK: - Layout
private extension DatePickerView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 35),
            widthAnchor.constraint(equalTo: customDatePicker.widthAnchor)
        ])
    }
}
