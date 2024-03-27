//
//  PersonTitleView.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 14.03.2024.
//

import UIKit

final class PersonTitleView: UIView {
    
    // MARK: Views
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.header
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: Initialize
    init() {
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
    
    // MARK: Public Methods
    func configure(withFullName fullName: String) {
        fullNameLabel.text = fullName
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
            photoImageView.heightAnchor.constraint(equalToConstant: 100),
            photoImageView.widthAnchor.constraint(equalToConstant: 100),
            
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
