//
//  HeaderCollectionReusableView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.04.2024.
//

import UIKit

final class HeaderCollectionReusableView: UICollectionReusableView {
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "12.04.2024"
        label.font = Constants.Fonts.normal
        label.textColor = .accent
        return label
    }()
    
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
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 8),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension HeaderCollectionReusableView {
    
    static var identifier: String {
        String(describing: self)
    }
}
