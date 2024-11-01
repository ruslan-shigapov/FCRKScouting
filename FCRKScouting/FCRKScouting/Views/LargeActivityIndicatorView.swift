//
//  LargeActivityIndicatorView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 15.10.2024.
//

import UIKit

final class LargeActivityIndicatorView: UIActivityIndicatorView {

    init() {
        super.init(style: .large)
        setupUI()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    private func setupUI() {
        hidesWhenStopped = true
        color = .black
    }
    
    private func setConstraints() {
        guard let superview else { return }
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
    }
}
