//
//  WhiteLabel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 11.04.2024.
//

import UIKit

final class WhiteLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
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
