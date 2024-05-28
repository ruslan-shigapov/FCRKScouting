//
//  FiltersViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 30.03.2024.
//

import UIKit

final class FiltersViewController: UIViewController {
    
    private let titleLabel = CustomLabel(
        font: Constants.Fonts.header,
        text: "Применить фильтры")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(titleLabel)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            titleLabel.topAnchor.constraint(
                equalTo: view.topAnchor, 
                constant: 24),
        ])
    }
}
