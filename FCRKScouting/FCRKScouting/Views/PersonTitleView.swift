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
    private lazy var fullNameLabel = HeaderLabel(title: title)
    
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
    
    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.layer.cornerRadius = photoImageView.frame.width / 2
    }
    
    // MARK: Private Methods
    private func setupUI() {
        backgroundColor = .accent
        addSubview(photoImageView)
        addSubview(fullNameLabel)
        layer.cornerRadius = 12
        setConstraints()
    }
}

// MARK: - Layout
private extension PersonTitleView {
    
    func prepareForAutoLayout(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        subviews.forEach(prepareForAutoLayout)
        
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
            
            fullNameLabel.leadingAnchor.constraint(
                equalTo: photoImageView.trailingAnchor,
                constant: 32),
            fullNameLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -32),
            fullNameLabel.centerYAnchor.constraint(
                equalTo: photoImageView.centerYAnchor)
        ])
    }
}
