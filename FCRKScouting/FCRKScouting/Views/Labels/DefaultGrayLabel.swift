//
//  DefaultGrayLabel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 28.05.2024.
//

import UIKit

final class DefaultGrayLabel: UILabel {
    
    init(text: String? = nil) {
        super.init(frame: .zero)
        self.text = text
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        textColor = .lightGray
        font = Constants.Fonts.text
    }
}
