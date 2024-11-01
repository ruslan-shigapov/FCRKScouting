//
//  StackViewWithDescription.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 15.10.2024.
//

import UIKit

final class StackViewWithDescription: UIStackView {

    private let mainView: UIView
    private let text: String
    
    private lazy var descriptionLabel: UILabel = {
        $0.font = Constants.Fonts.description
        $0.text = text
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    init(mainView: UIView, text: String) {
        self.mainView = mainView
        self.text = text
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        axis = .vertical
        spacing = 8
        addArrangedSubview(mainView)
        addArrangedSubview(descriptionLabel)
    }
}
