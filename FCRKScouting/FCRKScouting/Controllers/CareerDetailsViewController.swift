//
//  CareerDetailsViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 17.06.2024.
//

import UIKit

final class CareerDetailsViewController: UIViewController {
    
    private let titleLabel = CustomWhiteLabel(
        font: Constants.Fonts.header,
        numberOfLines: 2,
        text: Constants.Text.ScreenTitles.career)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.textAlignment = .center
        titleLabel.textColor = .systemGreen
        view.backgroundColor = .accent
        view.addSubview(titleLabel)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 24),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            titleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
        ])
    }
}
