//
//  FiltersViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 30.03.2024.
//

import UIKit

final class FiltersViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Применить фильтры"
        label.font = Constants.Fonts.header
        label.textColor = .white
        return label
    }()

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
                constant: 24
            ),
            titleLabel.topAnchor.constraint(
                equalTo: view.topAnchor, 
                constant: 24
            ),
        ])
    }
}
