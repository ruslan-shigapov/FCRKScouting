//
//  PlayerCollectionViewCell.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.04.2024.
//

import UIKit

final class PlayerCollectionViewCell: UICollectionViewCell {
    
    private let photoImageView = PhotoImageView()
    private lazy var fullNameLabel = HeaderLabel()
    private lazy var ageLabel = WhiteLabel()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.layer.cornerRadius = photoImageView.frame.width / 2
    }
    
    private func setupUI() {
        backgroundColor = .accent
        ageLabel.textAlignment = .right
        addSubviews()
        layer.cornerRadius = 12
        setConstraints()
    }
    
    private func addSubviews() {
        addSubview(photoImageView)
        addSubview(fullNameLabel)
        addSubview(ageLabel)
    }
    
    func configure(
        withFullName fullName: String, 
        age: String,
        photo: UIImage?
    ) {
        fullNameLabel.text = fullName
        ageLabel.text = age
        if let photo {
            photoImageView.image = photo
        }
    }
}

extension PlayerCollectionViewCell {
    
    static var identifier: String {
        String(describing: self)
    }
}

// MARK: - Layout
private extension PlayerCollectionViewCell {
    
    func setConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 12),
            photoImageView.centerYAnchor.constraint(
                equalTo: centerYAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 70),
            photoImageView.widthAnchor.constraint(equalToConstant: 70),
            
            fullNameLabel.leadingAnchor.constraint(
                equalTo: photoImageView.trailingAnchor,
                constant: 24),
            fullNameLabel.centerYAnchor.constraint(
                equalTo: centerYAnchor),
            
            ageLabel.leadingAnchor.constraint(
                equalTo: fullNameLabel.trailingAnchor,
                constant: 24),
            ageLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24),
            ageLabel.centerYAnchor.constraint(
                equalTo: centerYAnchor),
            ageLabel.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}
