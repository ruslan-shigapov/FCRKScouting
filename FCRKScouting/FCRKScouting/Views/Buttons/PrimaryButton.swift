//
//  PrimaryButton.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 14.03.2024.
//

import UIKit

final class PrimaryButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemGreen
        setTitleColor(.white, for: .normal)
        titleLabel?.font = Constants.Fonts.normal
        setCustomCornerRadius()
        setCustomShadow()
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 300),
            heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
