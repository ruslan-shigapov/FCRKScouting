//
//  PlayerCollectionViewCell.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 12.04.2024.
//

import UIKit

final class PlayerCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .accent
        layer.cornerRadius = 12
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "S A L A M"
        label.textColor = .white
        addSubview(label)
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

extension PlayerCollectionViewCell {
    
    static var identifier: String {
        String(describing: self)
    }
}
