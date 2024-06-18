//
//  FiltersViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 30.03.2024.
//

import UIKit

final class FiltersViewController: UIViewController {
    
    private let titleLabel = CustomWhiteLabel(
        font: Constants.Fonts.header,
        text: Constants.Text.ScreenTitles.filters)

    override func viewDidLoad() {
        super.viewDidLoad()
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
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
