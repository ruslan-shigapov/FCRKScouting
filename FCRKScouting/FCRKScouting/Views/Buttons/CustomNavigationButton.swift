//
//  CustomNavigationButton.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 17.05.2024.
//

import UIKit

final class CustomNavigationButton: UIButton {
    
    private let paddingView = UIView()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
        setCustomCornerRadius()
        addSubview(arrowImageView)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            arrowImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16),
            arrowImageView.centerYAnchor.constraint(
                equalTo: centerYAnchor,
                constant: -2)
        ])
    }
}
