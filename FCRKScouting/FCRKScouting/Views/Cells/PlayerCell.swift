//
//  PlayerCell.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.04.2024.
//

import UIKit

final class PlayerCell: UICollectionViewCell {
    
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
        stackView.distribution = .fillEqually
        stackView.spacing = -10
        stackView.layer.borderWidth = 2
        stackView.layer.borderColor = UIColor.accent.cgColor
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    // MARK: Public Properties
    var viewModel: PlayerCellViewModelProtocol? {
        didSet {
            if let photo = viewModel?.photo {
                photoImageView.image = photo
            }
            fullNameLabel.text = viewModel?.fullName
            ageLabel.text = viewModel?.ageDescription
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
        backgroundColor = Constants.Colors.deepGreen
        setCustomCornerRadius()
        addSubviews(photoImageView, fullNameLabel, infoStackView)
        prepareForAutoLayout()
        setConstraints()
    }
}

// MARK: - Layout
private extension PlayerCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 12),
            photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 70),
            photoImageView.widthAnchor.constraint(equalToConstant: 70),
            
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
            infoStackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
