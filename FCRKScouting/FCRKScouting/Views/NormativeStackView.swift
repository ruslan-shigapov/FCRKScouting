//
//  NormativeStackView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 28.05.2024.
//

import UIKit

final class NormativeStackView: UIStackView {
    
    private let title: String
    private let textFieldView: UIView

    private lazy var titleLabel = DefaultLabel(text: title)
    private let spacerView = UIView()
    
    init(title: String, textFieldView: UIView) {
        self.title = title
        self.textFieldView = textFieldView
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addArrangedSubview(titleLabel)
        addArrangedSubview(spacerView)
        addArrangedSubview(textFieldView)
    }
}
