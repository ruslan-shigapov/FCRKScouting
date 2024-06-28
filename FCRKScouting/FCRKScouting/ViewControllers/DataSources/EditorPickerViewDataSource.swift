//
//  EditorPickerViewDataSource.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 30.05.2024.
//

import UIKit

final class EditorPickerViewDataSource: NSObject, UIPickerViewDataSource {
    
    private let viewModel: EditorViewModelProtocol
    
    init(viewModel: EditorViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        viewModel.getNumberOfComponentsInPicker()
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        viewModel.getNumberOfRowsInPicker()
    }
}
