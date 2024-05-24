//
//  AthleticDetailsViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 24.05.2024.
//

import UIKit

final class AthleticDetailsViewController: UIViewController {
    
    private let titleLabel = PrimaryLabel(
        font: Constants.Fonts.header,
        numberOfLines: 2,
        text: "Антропометрия и \n Атлетические данные")

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
