//
//  NavigationButton.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 17.05.2024.
//

import UIKit

final class NavigationButton: UIButton {
    
    private let soonLabel = CustomLabel(
        font: Constants.Fonts.secondary,
        text: "скоро")
            
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.ButtonImages.arrow
        imageView.tintColor = .systemGreen
        return imageView
    }()

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
        backgroundColor = .accent
        titleLabel?.font = Constants.Fonts.normal
        setupCornerRadius()
        addSubviews(soonLabel, arrowImageView)
        prepareForAutoLayout()
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            soonLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            soonLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 8),
            
            arrowImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24),
            arrowImageView.centerYAnchor.constraint(
                equalTo: centerYAnchor,
                constant: -2)
        ])
    }
}
