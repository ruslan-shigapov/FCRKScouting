//
//  CustomWhiteLabel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 19.04.2024.
//

import UIKit

final class CustomWhiteLabel: UILabel {

    init(font: UIFont?, numberOfLines: Int = 1, text: String? = nil) {
        super.init(frame: .zero)
        self.font = font
        self.numberOfLines = numberOfLines
        self.text = text
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        textColor = .white
    }
}
