//
//  CustomWhiteLabel:.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 19.04.2024.
//

import UIKit

final class CustomWhiteLabel: UILabel {

    init(font: UIFont?, text: String? = nil, numberOfLines: Int = 1) {
        super.init(frame: .zero)
        self.font = font
        self.text = text
        self.numberOfLines = numberOfLines
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
