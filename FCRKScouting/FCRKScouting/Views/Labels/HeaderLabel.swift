//
//  HeaderLabel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 10.04.2024.
//

import UIKit

final class HeaderLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
