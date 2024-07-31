//
//  DefaultTextLabel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 28.05.2024.
//

import UIKit

final class DefaultTextLabel: UILabel {
    
    init(text: String? = nil, numberOfLines: Int = 1) {
        super.init(frame: .zero)
        self.text = text
        self.numberOfLines = numberOfLines
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        font = Constants.Fonts.text
        textColor = .white.withAlphaComponent(0.7)
    }
}
