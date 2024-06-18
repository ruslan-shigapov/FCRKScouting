//
//  PrimaryButton.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 14.03.2024.
//

import UIKit

final class PrimaryButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(
                withDuration: 0.15,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: [.beginFromCurrentState, .allowUserInteraction]
            ) {
                self.transform = self.isHighlighted
                ? .init(scaleX: 0.94, y: 0.94)
                : .identity
            }
        }
    }
    
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
        backgroundColor = .systemGreen.withAlphaComponent(0.8)
        titleLabel?.font = Constants.Fonts.normal
        setCommonCornerRadius()
        heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
