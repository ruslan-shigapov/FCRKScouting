//
//  HeaderCollectionReusableView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.04.2024.
//

import UIKit

final class DateCollectionReusableView: UICollectionReusableView {
        
    // MARK: Views
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.normal
        label.textColor = .label
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

// MARK: - Reuse Identifier
extension DateCollectionReusableView {
    
    static var identifier: String {
        String(describing: self)
    }
}

// MARK: - Layout
private extension DateCollectionReusableView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 8),
            dateLabel.centerYAnchor.constraint(
                equalTo: centerYAnchor)
        ])
    }
}
