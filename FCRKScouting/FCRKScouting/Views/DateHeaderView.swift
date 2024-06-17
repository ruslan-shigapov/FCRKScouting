//
//  DateHeaderView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.04.2024.
//

import UIKit

final class DateHeaderView: UICollectionReusableView {
        
    private let dateLabel = CustomWhiteLabel(font: Constants.Fonts.normal)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(dateLabel)
        prepareForAutoLayout()
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16),
            dateLabel.centerYAnchor.constraint(
                equalTo: centerYAnchor,
                constant: 1)
        ])
    }
    
    func configureWith(date: String) {
        dateLabel.text = date
    }
}
