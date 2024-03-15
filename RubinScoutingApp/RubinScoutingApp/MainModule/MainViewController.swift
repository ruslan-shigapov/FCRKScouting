//
//  MainViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 12.03.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let userTitleView = PersonTitleView()
    
    private let logoutButton = PrimaryButton(
        title: Constants.Text.ButtonTitle.exit)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(logoutButton)
        view.addSubview(userTitleView)
        userTitleView.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        userTitleView.configure(
            withSurname: "Шигапов".uppercased(),
            andName: "Руслан".uppercased())
        
        logoutButton.addTarget(
            self,
            action: #selector(logOutButtonTapped),
            for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            userTitleView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 24),
            userTitleView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            userTitleView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24)
        ])
    }
    
    @objc private func logOutButtonTapped() {
        dismiss(animated: true)
    }
}
