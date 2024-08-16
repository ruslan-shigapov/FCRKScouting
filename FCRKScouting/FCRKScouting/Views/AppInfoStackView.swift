//
//  AppInfoStackView.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 14.08.2024.
//

import UIKit

final class AppInfoStackView: UIStackView {
    
    private let versionLabel = CustomLabel(
        font: Constants.Fonts.secondary,
        text: Constants.Texts.appVersion,
        color: .white)
    private let devContactsLabel = CustomLabel(
        font: Constants.Fonts.secondary,
        text: Constants.Texts.devContacts,
        color: .black)
    private let devTelegramLabel = CustomLabel(
        font: Constants.Fonts.secondary,
        text: Constants.Texts.devTelegram,
        color: .black)
    private let devEmailLabel = CustomLabel(
        font: Constants.Fonts.secondary,
        text: Constants.Texts.devEmail,
        color: .black)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        axis = .vertical
        spacing = 2
        addArrangedSubview(versionLabel)
        addArrangedSubview(devContactsLabel)
        addArrangedSubview(devTelegramLabel)
        addArrangedSubview(devEmailLabel)
    }
}
