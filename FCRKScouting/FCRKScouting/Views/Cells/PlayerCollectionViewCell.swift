//
//  PlayerCollectionViewCell.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.04.2024.
//

import UIKit

final class PlayerCollectionViewCell: UICollectionViewCell {
    
    // MARK: Views
    private let photoImageView = PhotoImageView()
    
    private let fullNameLabel = CustomWhiteLabel(
        font: Constants.Fonts.header,
        numberOfLines: 2)
    private let ageLabel = CustomWhiteLabel(font: Constants.Fonts.normal)
    private let positionLabel = CustomWhiteLabel(font: Constants.Fonts.normal)
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [ageLabel, positionLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
        
    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        addSubview(photoImageView)
        addSubview(fullNameLabel)
        addSubview(infoStackView)
    }
    
    // MARK: Public Methods
    func configureWith(
        fullName: String, 
        age: String,
        position: String,
        photo: UIImage?
    ) {
        fullNameLabel.text = fullName
        ageLabel.text = age
        positionLabel.text = position
        if let photo {
            photoImageView.image = photo
        }
    }
}

// MARK: - Reuse Identifier
extension PlayerCollectionViewCell {
    
    static var identifier: String {
        String(describing: self)
    }
}

// MARK: - Layout
private extension PlayerCollectionViewCell {
    
    func setConstraints() {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 18),
            photoImageView.centerYAnchor.constraint(
                equalTo: centerYAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 70),
            photoImageView.widthAnchor.constraint(equalToConstant: 70),
            
            fullNameLabel.leadingAnchor.constraint(
                equalTo: photoImageView.trailingAnchor,
                constant: 18),
            fullNameLabel.centerYAnchor.constraint(
                equalTo: centerYAnchor),
            
            infoStackView.leadingAnchor.constraint(
                equalTo: fullNameLabel.trailingAnchor,
                constant: 18),
            infoStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -12),
            infoStackView.centerYAnchor.constraint(
                equalTo: centerYAnchor),
            infoStackView.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}
