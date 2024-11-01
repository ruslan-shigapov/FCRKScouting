//
//  NoResultsLabel.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 16.10.2024.
//

import UIKit

final class NoResultsLabel: UILabel {

    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    private func setupUI() {
        isHidden = true
        font = Constants.Fonts.text
        textColor = .white
        textAlignment = .center
        numberOfLines = 0
    }
    
    private func setConstraints() {
        guard let superview else { return }
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor),
            widthAnchor.constraint(equalToConstant: 170)
        ])
    }
}
