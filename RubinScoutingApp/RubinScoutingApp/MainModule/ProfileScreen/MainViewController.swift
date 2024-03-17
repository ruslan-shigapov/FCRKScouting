//
//  MainViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 12.03.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let viewModel: MainViewModelProtocol
    
    private let userTitleView = PersonTitleView()
    
    private let logoutButton = PrimaryButton(
        title: Constants.Text.ButtonTitle.exit)
    
    private let accessLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = .white
        label.text = "Доступ"
        label.font = Constants.Fonts.normal
        return label
    }()
    
    private let postLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "Должность"
        label.font = Constants.Fonts.normal
        return label
    }()
    
    private let postValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Разработчик"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let accessValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Только чтение"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .accent
        view.layer.cornerRadius = 12
        view.addSubview(logoutButton)
        view.addSubview(postLabel)
        view.addSubview(postValueLabel)
        view.addSubview(accessLabel)
        view.addSubview(accessValueLabel)
        return view
    }()
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(userTitleView)
        view.addSubview(backgroundView)
        userTitleView.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        userTitleView.configure(
            withSurname: "Шигапов",
            andName: "Руслан")
        
        logoutButton.addTarget(
            self,
            action: #selector(logOutButtonTapped),
            for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            logoutButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -24),
            logoutButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            
            userTitleView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 24),
            userTitleView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            userTitleView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            
            backgroundView.topAnchor.constraint(equalTo: userTitleView.bottomAnchor, constant: 24),
            backgroundView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            backgroundView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            
            postLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),
            accessLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),

            postLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 24),
            accessLabel.topAnchor.constraint(equalTo: postLabel.bottomAnchor, constant: 48),
            logoutButton.topAnchor.constraint(equalTo: accessLabel.bottomAnchor, constant: 48),
            
            postValueLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),
            accessValueLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),
            postValueLabel.topAnchor.constraint(equalTo: postLabel.bottomAnchor, constant: 5),
            accessValueLabel.topAnchor.constraint(equalTo: accessLabel.bottomAnchor, constant: 5),
        ])
    }
    
    @objc private func logOutButtonTapped() {
        StorageManager.shared.deleteUser()
        dismiss(animated: true)
    }
}
