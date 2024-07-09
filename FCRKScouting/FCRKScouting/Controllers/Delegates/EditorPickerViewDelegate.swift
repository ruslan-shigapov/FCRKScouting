//
//  EditorPickerViewDelegate.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 30.05.2024.
//

import UIKit

final class EditorPickerViewDelegate: NSObject, UIPickerViewDelegate {
    
    private let viewModel: EditorViewModelProtocol
    
    init(viewModel: EditorViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusing view: UIView?
    ) -> UIView {
        let rowLabel = UILabel()
        rowLabel.text = viewModel.getTitleFor(pickerRow: row)
        rowLabel.font = Constants.Fonts.text
        rowLabel.textColor = .black
        rowLabel.textAlignment = .center
        return rowLabel
    }
}
