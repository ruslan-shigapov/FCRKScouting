//
//  AddPlayerViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 29.03.2024.
//

import UIKit

final class AddPlayerViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.ScreenTitles.addPlayer
        label.font = Constants.Fonts.header
        label.textColor = .white
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.addTarget(
            self,
            action: #selector(cancelButtonTapped),
            for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .lightGray
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        setConstraints()
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - Layout
private extension AddPlayerViewController {
    
    func prepareForAutoLayout(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        view.subviews.forEach(prepareForAutoLayout)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            titleLabel.centerYAnchor.constraint(
                equalTo: closeButton.centerYAnchor),
            
            closeButton.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 24),
            closeButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24)
        ])
    }
}
