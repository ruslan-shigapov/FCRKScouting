//
//  LoginViewController.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 04.03.2024.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "RUBIN SCOUTING"
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let accessKeyTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 12
        textField.backgroundColor = .white
        textField.placeholder = "Введите ключ доступа"
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "AccentColor")
        view.addSubview(logoImageView)
        view.addSubview(nameLabel)
        view.addSubview(accessKeyTextField)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 24),
            logoImageView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 24),
            nameLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            
            accessKeyTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 100),
            accessKeyTextField.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            accessKeyTextField.widthAnchor.constraint(equalToConstant: 300),
            accessKeyTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

