//
//  DescriptionLabel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 19.04.2024.
//

import UIKit

final class DescriptionLabel: UILabel {

    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        textColor = .white
        font = Constants.Fonts.description
        numberOfLines = 2
    }
}
