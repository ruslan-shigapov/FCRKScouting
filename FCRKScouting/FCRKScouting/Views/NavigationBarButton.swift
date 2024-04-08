//
//  NavigationBarButton.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 28.03.2024.
//

import UIKit

final class NavigationBarButton: UIButton {
    
    init(image: UIImage?) {
        super.init(frame: .zero)
        setImage(image, for: .normal)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        tintColor = .white
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 32),
            widthAnchor.constraint(equalToConstant: 32)
        ])
    }
}
