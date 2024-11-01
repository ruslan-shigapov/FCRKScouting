//
//  TournamentCollectionViewCell.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 23.09.2024.
//

import UIKit

final class TournamentCollectionViewCell: UICollectionViewCell {
    
    // MARK: Views
    private lazy var nameLabel = CustomLabel(font: Constants.Fonts.normal)
    
    private lazy var dateAndPlaceLabel = CustomLabel(
        font: Constants.Fonts.text,
        color: .white.withAlphaComponent(0.7))
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [nameLabel, dateAndPlaceLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var ageLabel = CustomLabel(
        font: Constants.Fonts.normal,
        numberOfLines: 2)
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ageLabel])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.layer.borderWidth = 2
        stackView.layer.borderColor = UIColor.rubin.cgColor
        stackView.setupCornerRadius()
        return stackView
    }()
    
    // MARK: Public Properties
    var viewModel: TournamentCellViewModelProtocol? {
        didSet {
            nameLabel.text = viewModel?.name
            dateAndPlaceLabel.text = viewModel?.dateAndPlace
            ageLabel.text = viewModel?.age
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
        addSubviews(titleStackView, infoStackView)
        prepareForAutoLayout()
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16),
            titleStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            infoStackView.leadingAnchor.constraint(
                equalTo: titleStackView.trailingAnchor,
                constant: 12),
            infoStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16),
            infoStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoStackView.widthAnchor.constraint(equalToConstant: 65),
            infoStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
