//
//  StatisticsDetailsViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 20.06.2024.
//

import UIKit

final class StatisticsDetailsViewController: UIViewController {

    private let titleLabel = CustomWhiteLabel(
        font: Constants.Fonts.header,
        text: "Статистика")

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
