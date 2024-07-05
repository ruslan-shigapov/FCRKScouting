//
//  PlayerExtraCard.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 05.07.2024.
//

import UIKit

final class PlayerExtraCard: UIView {

    // MARK: Views
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.deepGreen
        view.setupCornerRadius()
        view.setupBorder()
        
        view.prepareForAutoLayout()
        return view
    }()

    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods
    private func setupUI() {
        addSubview(backgroundView)
        prepareForAutoLayout()
        setConstraints()
    }
}

// MARK: - Layout
private extension PlayerExtraCard {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16)
        ])
    }
}
