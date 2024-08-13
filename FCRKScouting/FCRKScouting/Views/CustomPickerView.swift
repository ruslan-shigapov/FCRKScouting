//
//  CustomPickerView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 21.07.2024.
//

import UIKit

enum PickerViewType {
    case position, league
}

final class CustomPickerView: UIPickerView {
    
    private let type: PickerViewType

    init(type: PickerViewType) {
        self.type = type
        super.init(frame: .zero)
        setupUI()
        delegate = self
        dataSource = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
    }
    
    private func setupUI() {
        backgroundColor = .white
        setupCornerRadius()
    }
}

// MARK: - Picker View Delegate
extension CustomPickerView: UIPickerViewDelegate {
    
    func pickerView(
        _ pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusing view: UIView?
    ) -> UIView {
        let rowLabel = UILabel()
        rowLabel.text = switch type {
        case .position: Constants.Texts.Positions.allCases[row].rawValue
        case .league: Constants.Texts.Leagues.allCases[row].rawValue
        }
        rowLabel.font = Constants.Fonts.text
        rowLabel.textColor = .black
        rowLabel.textAlignment = .center
        return rowLabel
    }
}

// MARK: - Picker View Data Source 
extension CustomPickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        switch type {
        case .position: Constants.Texts.Positions.allCases.count
        case .league: Constants.Texts.Leagues.allCases.count
        }
    }
}
