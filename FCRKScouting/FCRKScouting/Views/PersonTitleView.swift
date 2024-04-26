//
//  PersonTitleView.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 14.03.2024.
//

import UIKit

final class PersonTitleView: UIView {
    
    // MARK: Private Properties
    private let title: String
    
    // MARK: Views
    private let photoImageView = PhotoImageView()
    
    private lazy var fullNameLabel = CustomWhiteLabel(
        font: Constants.Fonts.header,
        numberOfLines: 2,
        text: title)
    
    // MARK: Initialize
    init(title: String) {
        self.title = title
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
        setCustomCornerRadius()
        addSubview(photoImageView)
        addSubview(fullNameLabel)
        setConstraints()
    }
}

// MARK: - Layout
private extension PersonTitleView {
    
    func setConstraints() {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 24),
            photoImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 24),
            photoImageView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -24),
            photoImageView.heightAnchor.constraint(equalToConstant: 100),
            photoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            fullNameLabel.leadingAnchor.constraint(
                equalTo: photoImageView.trailingAnchor,
                constant: 24),
            fullNameLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24),
            fullNameLabel.centerYAnchor.constraint(
                equalTo: photoImageView.centerYAnchor)
        ])
    }
}
