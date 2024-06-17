//
//  UserInfoView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 18.05.2024.
//

import UIKit

final class UserInfoView: UIView {
    
    // MARK: Views
    private let postLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.post)
    private let accessLabel = CustomWhiteLabel(
        font: Constants.Fonts.normal,
        text: Constants.Text.access)
    
    private let postValueLabel = DefaultTextLabel()
    private let accessValueLabel = DefaultTextLabel()

    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func setupUI() {
        addSubviews(postLabel, accessLabel, postValueLabel, accessValueLabel)
        prepareForAutoLayout()
        setConstraints()
    }
    
    // MARK: Public Methods
    func configureWith(post: String, access: String) {
        postValueLabel.text = post
        accessValueLabel.text = access
    }
}

// MARK: - Layout
private extension UserInfoView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            postLabel.topAnchor.constraint(equalTo: topAnchor),
            postLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            postValueLabel.topAnchor.constraint(
                equalTo: postLabel.bottomAnchor,
                constant: 2),
            postValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            accessLabel.topAnchor.constraint(
                equalTo: postValueLabel.bottomAnchor,
                constant: 12),
            accessLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            accessValueLabel.topAnchor.constraint(
                equalTo: accessLabel.bottomAnchor,
                constant: 2),
            accessValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            accessValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
