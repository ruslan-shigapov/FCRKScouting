//
//  CareerDetailsViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 17.06.2024.
//

import UIKit

final class CareerDetailsViewController: UIViewController {
    
    private let titleLabel = CustomLabel(
        font: Constants.Fonts.header,
        text: Constants.Text.ScreenTitles.career,
        numberOfLines: 2)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.textColor = .systemGreen
        titleLabel.textAlignment = .center
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
