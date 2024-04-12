//
//  WhiteLabel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 11.04.2024.
//

import UIKit

final class WhiteLabel: UILabel {

    init(title: String) {
        super.init(frame: .zero)
        text = title
        setupUI()
    }
    
    private func setupUI() {
        textColor = .white
        font = Constants.Fonts.normal
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
