//
//  ViewingPlanViewController.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 23.09.2024.
//

import UIKit

final class ViewingPlanViewController: UIViewController {
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: Constants.Texts.ButtonTitles.back,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped))
        button.setTitleTextAttributes(
            [.font : Constants.Fonts.normal as Any],
            for: .normal)
        button.setTitleTextAttributes(
            [.font : Constants.Fonts.normal as Any],
            for: .highlighted)
        return button
    }()
    
    private let titleLabel: CustomLabel = {
        let label = CustomLabel(
            font: Constants.Fonts.header,
            text: Constants.Texts.ScreenTitles.viewingPlan,
            numberOfLines: 2,
            color: .systemGreen)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupNavigationBar()
        view.backgroundColor = .rubin
        view.addSubview(titleLabel)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension ViewingPlanViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            titleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16),
            
            
        ])
    }
}
