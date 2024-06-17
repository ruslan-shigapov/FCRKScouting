//
//  ToggleTextFieldDisplayButton.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 22.05.2024.
//

import UIKit

final class ToggleTextFieldDisplayButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        setImage(Constants.Images.ButtonImages.plus, for: .normal)
        setImage(Constants.Images.ButtonImages.minus, for: .selected)
        tintColor = .white
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        heightAnchor.constraint(equalToConstant: 25).isActive = true
        widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
