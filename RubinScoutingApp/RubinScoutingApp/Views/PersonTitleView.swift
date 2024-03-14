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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()
    
    // TODO: создать общий лейбл
    private let surnameLabel: UILabel = {
        let label = UILabel()
        label.text = "ШИГАПОВ"
        label.textColor = .white
        label.font = Constants.Fonts.header
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "РУСЛАН"
        label.textColor = .white
        label.font = Constants.Fonts.header
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [surnameLabel, nameLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
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
        addSubview(labelStackView)
        layer.cornerRadius = 12
        setConstraints()
    }
}

// MARK: - Layout
private extension PersonTitleView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 32),
            photoImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 32),
            photoImageView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -32),
            photoImageView.heightAnchor.constraint(equalToConstant: 100),
            photoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            labelStackView.leadingAnchor.constraint(
                equalTo: photoImageView.trailingAnchor,
                constant: 32),
            labelStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -32),
            labelStackView.centerYAnchor.constraint(
                equalTo: photoImageView.centerYAnchor)
        ])
    }
}
