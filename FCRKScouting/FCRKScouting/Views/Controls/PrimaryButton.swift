//
//  PrimaryButton.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 14.03.2024.
//

import UIKit

final class PrimaryButton: UIButton {
    
    init(title: String, color: UIColor = .systemGreen.withAlphaComponent(0.7)) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        backgroundColor = color
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setCommonShadow()
    }
    
    private func setupUI() {
        titleLabel?.font = Constants.Fonts.normal
        setCommonCornerRadius()
        setupHighlightAnimation()
        heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
