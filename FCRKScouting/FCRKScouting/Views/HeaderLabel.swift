//
//  HeaderLabel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 10.04.2024.
//

import UIKit

final class HeaderLabel: UILabel {
    
    init(title: String) {
        super.init(frame: .zero)
        text = title
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        font = Constants.Fonts.header
        textColor = .white
        numberOfLines = 2
    }
}
