//
//  DetailsButton.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 24.05.2024.
//

import UIKit

final class DetailsButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
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
        backgroundColor = .accent
        titleLabel?.font = Constants.Fonts.normal
        setCommonCornerRadius()
    }
}
