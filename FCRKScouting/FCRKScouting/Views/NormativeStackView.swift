//
//  NormativeStackView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 28.05.2024.
//

import UIKit

final class NormativeStackView: UIStackView {

    private let label: UILabel
    private let textField: UITextField
    
    init(label: UILabel, textField: UITextField) {
        self.label = label
        self.textField = textField
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addArrangedSubview(label)
        addArrangedSubview(textField)
    }
}
