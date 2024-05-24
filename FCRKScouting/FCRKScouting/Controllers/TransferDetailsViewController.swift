//
//  TransferDetailsViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 24.05.2024.
//

import UIKit

final class TransferDetailsViewController: UIViewController {

    private let titleLabel = PrimaryLabel(
        font: Constants.Fonts.header,
        numberOfLines: 2,
        text: Constants.Text.transferDetails)

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
            titleLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor)
        ])
    }
}
