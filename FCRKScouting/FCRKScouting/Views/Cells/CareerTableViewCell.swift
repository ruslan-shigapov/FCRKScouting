//
//  CareerTableViewCell.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 18.07.2024.
//

import UIKit

final class CareerTableViewCell: UITableViewCell {
    
    // MARK: Private Properties
    private let yearLabel: CustomLabel = {
        let label = CustomLabel(font: Constants.Fonts.normal)
        label.textAlignment = .center
        return label
    }()
    
    private let leagueLabel = DefaultTextLabel()
    private let coachLabel = DefaultTextLabel()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leagueLabel, coachLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        return stackView
    }()
    
    // MARK: Public Properties
    var viewModel: CareerCellViewModelProtocol? {
        didSet {
            yearLabel.text = viewModel?.year
            leagueLabel.text = viewModel?.league
            coachLabel.text = viewModel?.coachName
        }
    }

    // MARK: Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods 
    private func setupUI() {
        backgroundColor = .clear
        addSubviews(yearLabel, containerStackView)
        prepareForAutoLayout()
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            yearLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 8),
            yearLabel.widthAnchor.constraint(equalToConstant: 60),
            yearLabel.centerYAnchor.constraint(
                equalTo: centerYAnchor),
            
            containerStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 4),
            containerStackView.leadingAnchor.constraint(
                equalTo: yearLabel.trailingAnchor,
                constant: 16),
            containerStackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -4),
            containerStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16)
        ])
    }
}
