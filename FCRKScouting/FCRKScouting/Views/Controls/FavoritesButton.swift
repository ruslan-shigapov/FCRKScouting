//
//  FavoritesButton.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 18.07.2024.
//

import UIKit

final class FavoritesButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        tintColor = .naturalGold
        setImage(Constants.Images.ButtonImages.favoritesOff, for: .normal)
        setImage(Constants.Images.ButtonImages.favoritesOn, for: .selected)
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        heightAnchor.constraint(equalToConstant: 30).isActive = true
        widthAnchor.constraint(equalToConstant: 35).isActive = true
    }
}
