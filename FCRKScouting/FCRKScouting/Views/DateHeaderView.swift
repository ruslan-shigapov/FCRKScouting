//
//  DateHeaderView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.04.2024.
//

import UIKit

final class DateHeaderView: UICollectionReusableView {
        
    // MARK: Views
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.normal
        label.textColor = .darkGray
        return label
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
        addSubview(dateLabel)
        setConstraints()
    }
    
    // MARK: Public Methods
    func configureWith(date: String) {
        dateLabel.text = date
    }
}

// MARK: - Layout
private extension DateHeaderView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 8
            ),
            dateLabel.centerYAnchor.constraint(
                equalTo: centerYAnchor,
                constant: 1
            )
        ])
    }
}
