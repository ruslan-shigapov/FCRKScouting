//
//  CareerTableViewCell.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 18.07.2024.
//

import UIKit

final class CareerTableViewCell: UITableViewCell {
    
    // MARK: Views
    private let yearLabel: CustomLabel = {
        let label = CustomLabel(font: Constants.Fonts.normal)
        label.textAlignment = .center
        return label
    }()
    
    private let careerLabel = DefaultTextLabel()

    // MARK: Public Properties
    weak var viewModel: CareerCellViewModelProtocol? {
        didSet {
            guard let viewModel else { return }
            yearLabel.text = viewModel.year
            careerLabel.text = viewModel.careerInfo
        }
    }

    // MARK: Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    // MARK: Private Methods 
    private func setupUI() {
        backgroundColor = .clear
        addSubviews(yearLabel, careerLabel)
        prepareForAutoLayout()
    }
}

// MARK: - Layout
private extension CareerTableViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            yearLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 8),
            yearLabel.widthAnchor.constraint(equalToConstant: 60),
            yearLabel.centerYAnchor.constraint(
                equalTo: centerYAnchor,
                constant: 1),
            
            careerLabel.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor),
            careerLabel.leadingAnchor.constraint(
                equalTo: yearLabel.trailingAnchor,
                constant: 16),
            careerLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -8)
        ])
    }
}
