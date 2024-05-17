//
//  TitleViewWithImage.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 14.03.2024.
//

import UIKit

final class TitleViewWithImage: UIView {
    
    // MARK: Private Properties
    private let title: String?
    private let imageView: UIImageView
    
    // MARK: Views
    private lazy var fullNameLabel = CustomWhiteLabel(
        font: Constants.Fonts.header,
        numberOfLines: 2,
        text: title
    )
    
    // MARK: Initialize
    init(title: String?, imageView: UIImageView) {
        self.title = title
        self.imageView = imageView
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func setupUI() {
        backgroundColor = .accent
        fullNameLabel.textAlignment = .center 
        setCustomCornerRadius()
        addSubviews(imageView, fullNameLabel)
        prepareForAutoLayout()
        setConstraints()
    }
}

// MARK: - Layout
private extension TitleViewWithImage {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 24
            ),
            imageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 24
            ),
            imageView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -24
            ),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            
            fullNameLabel.leadingAnchor.constraint(
                equalTo: imageView.trailingAnchor,
                constant: 24
            ),
            fullNameLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24
            ),
            fullNameLabel.centerYAnchor.constraint(
                equalTo: imageView.centerYAnchor
            )
        ])
    }
}
