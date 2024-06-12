//
//  DatePickerView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 07.06.2024.
//

import UIKit

enum DatePickerType {
    case birth, contract
}

final class DatePickerView: UIView {
    
    private let type: DatePickerType
    
    private lazy var customDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        switch type {
        case .birth: datePicker.maximumDate = Date()
        case .contract: datePicker.minimumDate = Date()
        }
        return datePicker
    }()

    init(type: DatePickerType) {
        self.type = type
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setCustomShadow()
    }
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(customDatePicker)
        prepareForAutoLayout()
        setConstraints()
        setCustomCornerRadius()
    }
    
    func getDate() -> Date {
        customDatePicker.date
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
