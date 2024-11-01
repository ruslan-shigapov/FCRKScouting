//
//  PlayerCollectionViewCell.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.04.2024.
//

import UIKit

final class PlayerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: PlayerCollectionViewCell.self)
    
    // MARK: Views
    private let photoImageView = PhotoImageView()
    
    private let fullNameLabel = CustomLabel(
        font: Constants.Fonts.header,
        numberOfLines: 2)
    
    private let birthYear = CustomLabel(font: Constants.Fonts.normal)
    private let positionLabel = CustomLabel(font: Constants.Fonts.normal)
    
    private lazy var infoStackView: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.spacing = -10
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.rubin.cgColor
        $0.setupCornerRadius()
        return $0
    }(UIStackView(arrangedSubviews: [birthYear, positionLabel]))
    
    // MARK: Public Properties
    weak var viewModel: PlayerCellViewModel? {
        didSet {
            if let photo = viewModel?.photo {
                photoImageView.image = photo
            } else {
                photoImageView.image = Constants.Images.photoPlaceholder
            }
            fullNameLabel.text = viewModel?.fullName
            birthYear.text = viewModel?.ageDescription
            positionLabel.text = viewModel?.position
        }
    }
            
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
        backgroundColor = .deepGreen 
        setupBorder(withColor: .naturalGold)
        setupCornerRadius()
        addSubviews(photoImageView, fullNameLabel, infoStackView)
        prepareForAutoLayout()
        setConstraints()
    }
}

// MARK: - Layout
private extension PlayerCollectionViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 12),
            photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 70),
            photoImageView.heightAnchor.constraint(
                equalTo: photoImageView.widthAnchor),
            
            fullNameLabel.leadingAnchor.constraint(
                equalTo: photoImageView.trailingAnchor,
                constant: 12),
            fullNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            infoStackView.leadingAnchor.constraint(
                equalTo: fullNameLabel.trailingAnchor,
                constant: 12),
            infoStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -12),
            infoStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoStackView.widthAnchor.constraint(equalToConstant: 60),
            infoStackView.heightAnchor.constraint(
                equalTo: infoStackView.widthAnchor)
        ])
    }
}
